
#
# Cookbook Name:: oracle_mysql
# Provider:: harden
#
# Copyright IBM Corp. 2017, 2017
#

include MysqlHelpers
use_inline_resources

def set_password
  if mysql_installed?(@new_resource.data_dir, @new_resource.version)
    Chef::Log.info "MySQL is installend, proceeding with set a new password action."
    converge_by("Setting MySQL server password for root user") do
      if node['platform'] == 'ubuntu'
        connection_query = "mysql -u root mysql -e"
        change_rootpwd_query = "\"UPDATE user SET authentication_string = PASSWORD(\'#{@new_resource.password}\'), plugin = \'mysql_native_password\' WHERE Host = \'localhost\' AND User = \'root\'; flush privileges;\""
        connection_query_retry = "mysql -u root mysql -p\'#{@new_resource.password}\' -e"
        change_rootpwd_cmd = shell_out(connection_query+change_rootpwd_query)
        if !change_rootpwd_cmd.stderr.empty?
          change_rootpwd_cmd = shell_out!(connection_query_retry+change_rootpwd_query)
          change_rootpwd_cmd.stderr.empty?
        else
          !change_rootpwd_cmd.stderr.empty?
        end
      else
        retrieve_cmd = shell_out!("cat #{@new_resource.log_file} | grep \"password is generated for root\"")
        if (retrieved_obj = /localhost:\s+(.*)/.match(retrieve_cmd.stdout.lines[0]))
          retrieved_pwd = retrieved_obj[1]
        else
          raise "Could not retrieve default password!"
        end
        retrieve_cmd.stderr.empty?

        connection_query = "mysql --connect-expired-password -u root mysql -p\'#{retrieved_pwd}\' -e"
        set_rootpwd_query = "\"ALTER USER \'root\'@\'localhost\' IDENTIFIED BY \'#{@new_resource.password}\';\""
        set_rootpwd_cmd = shell_out!(connection_query+set_rootpwd_query)

        set_rootpwd_cmd.stderr.empty?
      end
    end
  else
    raise "MySQL is not installed. Please install the product first."
  end
end

def change_password
  if mysql_installed?(@new_resource.data_dir, @new_resource.version)
    Chef::Log.info "MySQL is installend, proceeding with set a new password action."
    converge_by("Changing MySQL server password for root user") do
      if node['platform'] == 'ubuntu'
        connection_query = "mysql -u root mysql -e"
        change_rootpwd_query = "\"UPDATE user SET authentication_string = PASSWORD(\'#{@new_resource.new_password}\'), plugin = \'mysql_native_password\' WHERE Host = \'localhost\' AND User = \'root\'; flush privileges;\""
      else
        connection_query = "mysql -u root mysql -p\'#{@new_resource.password}\' -e"
        change_rootpwd_query = "\"ALTER USER \'root\'@\'localhost\' IDENTIFIED BY \'#{@new_resource.new_password}\';\""
      end
      connection_query_retry = "mysql -u root mysql -p\'#{@new_resource.new_password}\' -e"
      change_rootpwd_cmd = shell_out(connection_query+change_rootpwd_query)
      if !change_rootpwd_cmd.stderr.empty?
        change_rootpwd_cmd = shell_out!(connection_query_retry+change_rootpwd_query)
        change_rootpwd_cmd.stderr.empty?
      else
        !change_rootpwd_cmd.stderr.empty?
      end
    end
  else
    raise "Cannot update MySQL root user password. MySQL is not installed!"
  end
end

action :set do
  set_password
end

action :change do
  change_password
end
