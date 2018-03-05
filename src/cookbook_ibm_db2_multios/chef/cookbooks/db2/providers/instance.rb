#
# Cookbook Name:: db2
# Provider:: db2_instance
#
# Copyright IBM Corp. 2017, 2017
#
include DB2::Helper
include DB2::OS
use_inline_resources

action :create do
  if @current_resource.db2_instance_created
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Install #{@new_resource}") do
      raise "db2 instance prefix is limited to 8 character" if new_resource.instance_prefix.length > 8
      if ::File.exist?(new_resource.instance_dir)
        raise "Instance directory #{new_resource.instance_dir} exists and not owned by #{new_resource.instance_username}" unless ::Etc.getpwuid(::File.stat(new_resource.instance_dir).uid).name == new_resource.instance_username
      end
      [new_resource.rsp_file_path, new_resource.log_dir].each do |path|
        directory "Creating #{path} for new instance #{new_resource.instance_username}" do
          path path
          mode '777' # ~mode_checker
          recursive true
          action :create
        end
      end

      # Manage instance_dir
      # Create parent if it doesn't exist, let 'user' resource handle the rest
      # Fail if dirs above exist and not traversable by 'other'
      instance_dir = if new_resource.instance_dir.empty?
                       '/home/' + new_resource.instance_username
                     else
                       new_resource.instance_dir
                     end
      subdirs, reason = subdirs_to_create(::File.dirname(instance_dir), 'nobody')
      raise reason unless reason.empty?
      subdirs.each do |dir|
        next if dir.empty? || dir.nil?
        directory "create instance_dir: #{dir}" do
          path dir
          action :create
          mode '755'
          recursive true
          not_if { dir == '/home' }
          not_if { dir == '/' }
        end
      end

      # Manage ulimits for instance user
      template "/etc/security/limits.d/50-db2-#{new_resource.instance_username}.conf" do
        source 'db2_limits.conf.erb'
        owner 'root'
        mode '644'
        variables(
          :USER => new_resource.instance_username,
          :LIMITS => node['db2']['ulimit']
        )
      end

      ## Create DB2 instance repsonse file
      rsp_file = "#{new_resource.rsp_file_path}/db2_instance_#{new_resource.instance_username}.rsp"
      template rsp_file do
        source 'db2_instance.rsp.erb'
        owner 'root'
        group 'root'
        mode '0644'
        sensitive true
        variables(
          :INSTANCE_PREFIX => new_resource.instance_prefix,
          :DB2_INSTALL_DIR => new_resource.db2_install_dir,
          :INSTANCE_TYPE => new_resource.instance_type,
          :INSTANCE_USERNAME => new_resource.instance_username,
          :INSTANCE_GROUPNAME => new_resource.instance_groupname,
          :INSTANCE_PASSWORD => new_resource.instance_password,
          :INSTANCE_DIR => instance_dir,
          :PORT => new_resource.port,
          :FENCED_USERNAME => new_resource.fenced_username,
          :FENCED_GROUPNAME => new_resource.fenced_groupname,
          :FENCED_PASSWORD => new_resource.fenced_password,
          :FCM_PORT => new_resource.fcm_port
        )
      end

      execute "Create_instance #{new_resource.instance_prefix}" do
        cwd new_resource.db2_install_dir + '/instance'
        command "./db2isetup -l #{new_resource.log_dir}/DB2_create_instance_#{new_resource.instance_prefix}.log -r #{new_resource.rsp_file_path}/db2_instance_#{new_resource.instance_username}.rsp"
      end
      execute "Saving logfile for #{new_resource.instance_prefix}" do
        command "mv #{new_resource.log_dir}/DB2_create_instance_#{new_resource.instance_prefix}.log #{node['ibm']['log_dir']}"
        only_if { ::File.exist?("#{new_resource.log_dir}/DB2_create_instance_#{new_resource.instance_prefix}.log") }
      end
      [new_resource.rsp_file_path, new_resource.log_dir].each do |path|
        directory "Delete #{path} used for instance creation #{new_resource.instance_prefix}" do
          path path
          recursive true
          action :delete
        end
      end
    end
  end
end

#Override Load Current Resource
def load_current_resource
  @current_resource = Chef::Resource::Db2Instance.new(@new_resource.name)
  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  @current_resource.db2_install_dir(@new_resource.db2_install_dir)
  @current_resource.instance_username(@new_resource.instance_username)

  #Get current state
  @current_resource.db2_instance_created = db2_instance_created?(@new_resource.db2_install_dir, @new_resource.instance_username)
end
