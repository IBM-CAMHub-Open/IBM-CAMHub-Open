#
# Cookbook Name:: tomcat
# Provider:: link_dirs.rb
#
# Copyright IBM Corp. 2017, 2017
#

include TomcatHelper

use_inline_resources

def filetype(path)
  return nil unless ::File.exist?(path)
  return 'file' if ::File.file?(path)
  return 'dir' if ::File.directory?(path)
  return 'symlink' if ::File.symlink?(path)
  raise "File \'#{path}\' exists and is neither regular file, directory or symlink."
end

def expected_perms?(dir, user, group)
  return false if filetype(dir).nil?
  Etc.getpwnam(user).uid == ::File.stat(dir).uid && Etc.getgrnam(group).gid == ::File.stat(dir).gid
end

action :link do
  dest_dir = new_resource.dest_dir
  source_dir = new_resource.source_dir
  owner = new_resource.owner
  group = new_resource.group
  mode = new_resource.mode

  Chef::Log.debug("Linking \'#{source_dir}\' to \'#{dest_dir}\', ownership #{owner}:#{group}")
  Chef::Log.debug("Initial file types: source \'#{source_dir}\' is #{filetype(source_dir)}, destination \'#{dest_dir}\' is #{filetype(dest_dir)}")

  [new_resource.dest_dir, new_resource.source_dir, new_resource.owner, new_resource.group].each do |item|
    raise "You need to provide a value for \'#{item}\'" if item.nil? || item.empty?
  end

  # Abort if we cannot handle the input data
  raise "\'#{dest_dir}\' exists but is not a directory" unless ['dir', nil].include?(filetype(dest_dir))
  if filetype(dest_dir) == 'dir'
    raise "\'#{dest_dir}\' exists and not owned by #{owner}:#{group}"'dir' unless expected_perms?(dest_dir, owner, group)
  end
  unless ['dir', 'symlink', nil].include?(filetype(source_dir))
    raise "Source directory should be either directory or symlink, \'#{source_dir}\'"
  end
  # raise "Destination path \'#{dest_dir}\' is unreachable by user \'#{owner} \'" unless can_traverse?(owner, dest_dir)

  subdirs, reason = subdirs_to_create(dest_dir, owner)
  raise reason unless reason.empty?
  subdirs.each do |subdir|
    directory "manage #{subdir} for linking #{::File.basename(source_dir)}" do
      path subdir
      action :create
      recursive true
      owner owner
      group group
      mode mode
      notifies :run, "ruby_block[moving data to #{dest_dir}]", :immediately if subdir == dest_dir
    end
  end

  ruby_block "moving data to #{dest_dir}" do
    block do
      source = if ::File.symlink?(source_dir)
                 ::File.readlink(source_dir)
               else # to account for accidental deletion of symlink (day 2)
                 source_dir # raise "Source directory should be either dir or symlink, \'#{source_dir}\'"
               end
      # don't copy data over itself
      unless source == dest_dir
        # copy data if any
        if ['dir', 'symlink'].include?(filetype(source))
          Chef::Log.debug("Copying data from #{source} to #{dest_dir}")
          ::FileUtils.mv(::Dir.glob("#{source}/*"), dest_dir) unless (Dir.entries(source) - %w{ . .. }).empty?
        end
        # remove source
        ::FileUtils.remove_entry_secure(source, :force => true)
        new_resource.updated_by_last_action(true)
      end
    end
    action :nothing
    not_if { source_dir == dest_dir }
  end
  
  link "manage #{source_dir}" do
    to dest_dir
    target_file source_dir
    owner owner
    group group
    link_type :symbolic
    not_if { source_dir == dest_dir }
  end
end
