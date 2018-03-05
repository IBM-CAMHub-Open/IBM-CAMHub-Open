#
# Cookbook Name:: oracle_mysql
# Recipe:: Mysql_helpers
#
# Copyright IBM Corp. 2016, 2017
#
# <> Installation recipe (install.rb)
# <> This module provides helper functions for providers and recipes.

include Chef::Mixin::ShellOut

# <> This module provides helper functions for providers and recipes.
module MysqlHelpers
  # Split module into 2 parts as the rubocop rules permit only 100 lines in length for a module...
  def mysql_installed?(data_dir, version)
    Chef::Log.debug "mysql_installed? params: data_dir: #{data_dir}, version: #{version}"
    return false unless Dir.exist?("#{data_dir}/")
    case node['platform_family']
    when 'rhel'
      cmd = shell_out("rpm -qa | grep mysql | grep -v \"\\-mysql\\-\"")
      unless cmd.stdout.empty?
        cmd2 = shell_out!("mysql --version")
        if (match_obj = /Distrib\s+(\d+\.\d+\.\d+)/.match(cmd2.stdout.lines[0]))
          matched_ver = match_obj[1]
        else
          raise "Could not determine MySQL version or MySQL is not installed!"
        end
        return cmd2.stderr.empty? && (matched_ver == version)
      end

    when 'debian' || 'ubuntu'
      cmd = shell_out("dpkg -l | grep mysql | grep -v \"\\-mysql\\-\"")
      unless cmd.stdout.empty?
        cmd2 = shell_out!("mysql --version")
        if (match_obj = /Distrib\s+(\d+\.\d+\.\d+)/.match(cmd2.stdout.lines[0]))
          matched_ver = match_obj[1]
        else
          raise "Could not determine MySQL version or MySQL is not installed!"
        end
        return cmd2.stderr.empty? && (matched_ver == version)
      end
    end

    !cmd.stdout.empty?
  end

  # Split module into 2 parts as the rubocop rules permit only 100 lines in length for a module...
  module MySQL1
    def chef_vault_item(bag, id)
       if ChefVault::Item.vault?(bag, id)
         ChefVault::Item.load(bag, id)
       elsif node['chef-vault']['databag_fallback']
         Chef::DataBagItem.load(bag, id)
       else
         raise "Trying to load a regular data bag item #{id} from #{bag}, and databag_fallback is disabled"
       end
    end

    def database_exists?(database, data_dir, version, conn_user, conn_pass)
      Chef::Log.debug "database_exists? params: database: #{database} data_dir: #{data_dir}, version: #{version}, user: #{conn_user}, password: ''"
      return false unless mysql_installed?("#{data_dir}/", version)
      case node['platform']
      when 'redhat'
        connection_query = "mysql -u "+ conn_user + " -p" + conn_pass + " mysql -e "
        query = "\"show databases\""
        cmd = shell_out(connection_query+query)
        unless cmd.stdout.empty?
          if cmd.stdout.lines.map(&:chomp).include?(database)
            Chef::Log.info "Found database '#{database}'."
            cmd.stdout.lines.map(&:chomp).include?(database)
          else
            Chef::Log.debug "Could not find the requested MySQL database on the current instance!"
            cmd.stdout.empty?
          end
          #cmd.stdout.empty?
        end
      when 'ubuntu'
        connection_query = "mysql -u "+ conn_user + " -p" + conn_pass + " mysql -e "
        query = "\"show databases\""
        cmd = shell_out(connection_query+query)
        unless cmd.stdout.empty?
          if cmd.stdout.lines.map(&:chomp).include?(database)
            Chef::Log.info "Found database '#{database}'."
            cmd.stdout.lines.map(&:chomp).include?(database)
          else
            Chef::Log.debug "Could not find the requested MySQL database on the current instance!"
            cmd.stdout.empty?
          end
          #cmd.stdout.empty?
        end
      end
    end
  end

  # Split module into 2 parts as the rubocop rules permit only 100 lines in length for a module...
  module MySQL2
    include MySQL1
    def user_exists?(user, data_dir, version, conn_user, conn_pass)
      Chef::Log.debug "user_exists? params: user: #{user} data_dir: #{data_dir}, version: #{version}, user: #{conn_user}, password: ''"
      return false unless mysql_installed?("#{data_dir}/", version)
      case node['platform']
      when 'redhat'
        connection_query = "mysql -u "+ conn_user + " -p" + conn_pass + " mysql -e "
        query = "\"select user from user where user = \'"+ user + "\'\""
        cmd = shell_out(connection_query+query)
        unless cmd.stdout.empty?
          if cmd.stdout.lines.map(&:chomp).include?(user)
            Chef::Log.info "Found user '#{user}'."
          else
            raise "Could not find the requested database user on the current instance!"
          end
          !cmd.stdout.empty?
        end
      when 'ubuntu'
        connection_query = "mysql -u "+ conn_user + " -p" + conn_pass + " mysql -e "
        query = "\"select user from user where user = \'"+ user + "\'\""
        cmd = shell_out(connection_query+query)
        unless cmd.stdout.empty?
          if cmd.stdout.lines.map(&:chomp).include?(user)
            Chef::Log.info "Found user '#{user}'."
          else
            raise "Could not find the requested database user on the current instance!"
          end
          !cmd.stdout.empty?
        end
      end
    end

    def credential_check?(data_dir, conn_user, conn_pass)
      Chef::Log.debug "user_exists? data_dir: #{data_dir}, version: #{version}, params: user: #{conn_user}, password: ''"
      return false unless mysql_installed?("#{data_dir}/", version)
      case node['platform_family']
      when 'rhel'
        connection_query = "mysql -u "+ conn_user + " -p" + conn_pass + " mysql -e "
        query = "\"select user from user where 1=1\""
        cmd = shell_out(connection_query+query)
        if !cmd.stdout.empty?
          !cmd.stdout.empty?
        else
          cmd.stderr.empty?
        end
      end
    end
  end


  Chef::Recipe.send(:include, MysqlHelpers::MySQL1)
  Chef::Provider.send(:include, MysqlHelpers::MySQL1)
  Chef::Resource.send(:include, MysqlHelpers::MySQL1)
  Chef::Recipe.send(:include, MysqlHelpers::MySQL2)
  Chef::Provider.send(:include, MysqlHelpers::MySQL2)
  Chef::Resource.send(:include, MysqlHelpers::MySQL2)
  Chef::Recipe.send(:include, MysqlHelpers)
  Chef::Resource.send(:include, MysqlHelpers)
  Chef::Provider.send(:include, MysqlHelpers)
end
