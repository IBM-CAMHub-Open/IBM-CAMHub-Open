#
# Cookbook Name:: oracle_mysql
# Provider:: database
#
# Copyright IBM Corp. 2017, 2017
#

include MysqlHelpers
use_inline_resources

def database
  if mysql_installed?(@new_resource.data_dir, @new_resource.version) && !database_exists?(@new_resource.name, @new_resource.data_dir, @new_resource.version, 'root', @new_resource.conn_password)
    Chef::Log.info "MySQL is installend and the database was not previously created, proceeding with the create action."
    converge_by("Creating MySQL database...") do
      connection_query = "mysql -u root mysql -p\'#{@new_resource.conn_password}\' -e"
      createdb_query = "\"CREATE DATABASE #{@new_resource.name}\""
      createdb_cmd = shell_out!(connection_query+createdb_query)

      createdb_cmd.stderr.empty?
    end
  elsif !mysql_installed?(@new_resource.data_dir, @new_resource.version)
    raise "MySQL is not installed. Please install the product first."
  else
    Chef::Log.info "MySQL database already exists. Nothing to do."
  end
end

action :create do
  database
end

action :update do
  database
end

action :remove do
  database
end
