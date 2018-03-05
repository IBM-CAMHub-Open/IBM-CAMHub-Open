# Cookbook Name:: tomcat
# Library:: tomcat_users
#
# Copyright IBM Corp. 2017, 2017
#

# <> library: Tomcat users
# <> Helper functions for handling tomcat-users.xml
module TomcatUsers
  # Helper functions for Tomcat cookbook

  # Process access control list from parameters, convert to XML
  class TomcatACL
    def initialize(acl, passwords)
      acl['users'].each_pair do |u, d|
        next if passwords['users'][u].nil?
        d['password'] = passwords['users'][u]['password']
      end

      @roles = enabled_roles(acl)
      @users = enabled_users(acl)
    end

    def empty?
      @users.empty? || @roles.empty?
    end

    def to_xml
      out = ''
      @doc = REXML::Document.new('', :attribute_quote => :quote)
      @doc.add_element(
        'tomcat-users',
        'xmlns' => 'http://tomcat.apache.org/xml',
        'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
        'xsi:schemaLocation' => 'http://tomcat.apache.org/xml tomcat-users.xsd',
        'version' => '1.0'
      )
      form = REXML::Formatters::Pretty.new
      process_acl
      form.write(@doc, out)
      out
    end

    private

    def enabled_roles(acls)
      roles_enabled = []
      acls['all_roles'].each_pair do |role, status|
        roles_enabled.push(role) if status == 'enabled'
        Chef::Log.debug("enabled role: #{role}")
      end
      roles_enabled
    end

    def enabled_users(acls)
      users_enabled = {}
      acls['users'].each_pair do |user, data|
        next unless data['status'] == 'enabled'
        next if data['password'].nil? || data['password'].empty?

        my_roles = []
        data['user_roles'].each_pair do |role, status|
          next unless @roles.include?(role)
          my_roles.push(role) if status == 'enabled'
        end
        next if my_roles.empty?

        Chef::Log.debug("enabled user: #{data['name']}")
        users_enabled[user] = {
          'name' => data['name'],
          'password' => hash_pwd(data['password']),
          'user_roles' => my_roles
        }
      end
      users_enabled
    end

    def process_acl
      @roles.each do |role|
        Chef::Log.debug("processing role: #{role}")
        @doc.root.add_element('role', 'rolename' => role)
      end

      @users.each_pair do |_user, data|
        Chef::Log.debug("processing user: #{data['name']}")
        @doc.root.add_element(
          'user',
          'username' => data['name'],
          'password' => data['password'],
          'roles' => data['user_roles'].join(', ')
        )
      end
    end

    def hash_pwd(passwd, salt = '', iterations = 1)
      if salt.empty? && iterations == 1
        Digest::SHA256.hexdigest(passwd)
      else
        pwd = Digest::SHA256.hexdigest([salt].pack('H*') + passwd)
        salt.to_s + '$' + iterations.to_s + '$' + pwd
      end
    end
  end
end
