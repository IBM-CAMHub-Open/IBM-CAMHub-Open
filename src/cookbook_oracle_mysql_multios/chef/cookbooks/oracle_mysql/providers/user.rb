#
# Cookbook Name:: oracle_mysql
# Provider:: user
#
# Copyright IBM Corp. 2017, 2017
#

include MysqlHelpers
use_inline_resources

def user
  if mysql_installed?(@new_resource.data_dir, @new_resource.version) && !user_exists?(@new_resource.name, @new_resource.data_dir, @new_resource.version, 'root', @new_resource.conn_password)
    Chef::Log.info "MySQL is installend and the user was not previously created, proceeding with the create action."
    converge_by("Creating MySQL user...") do
      connection_query = "mysql -u root mysql -p\'#{@new_resource.conn_password}\' -e "
      if @new_resource.password.length == 41
        create_user_query = "\"create user \'" + @new_resource.name + "\'@\'localhost\' identified by password \'" + @new_resource.password + "\'\""
      elsif @new_resource.password.length < 41
        create_user_query = "\"create user \'" + @new_resource.name + "\'@'localhost\' identified by \'" + @new_resource.password + "\'\""
      end
      createuser_cmd = shell_out!(connection_query+create_user_query)

      createuser_cmd.stderr.empty?
    end
  elsif !mysql_installed?(@new_resource.data_dir, @new_resource.version)
    raise "MySQL is not installed. Please install the product first."
  else
    Chef::Log.info "MySQL user already exists. Nothing to do."
  end
end

action :create do
  user
end

action :update do
  user
end

action :remove do
  user
end
