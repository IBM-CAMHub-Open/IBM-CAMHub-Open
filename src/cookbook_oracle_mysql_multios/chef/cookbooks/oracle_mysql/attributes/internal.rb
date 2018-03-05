#
# Cookbook Name:: db2
# attributes :: internal
#
# Copyright IBM Corp. 2017, 2017

# <> Base package repo path
force_override['mysql']['sw_repo_path'] = 'oracle/mysql/v5.7.17/base'

# <> Oracle MySQL archive names

case node['platform_family']
when 'rhel'
  # <> Archive names for RHEL6/7 and version separation
  if node['platform_version'].start_with?("7.")
    force_override['mysql']['archive_names'] = {
      '5.7.17' => {
        'filename' => 'mysql-' + node['mysql']['version'] + '-1.el7.x86_64.rpm-bundle.tar',
        'sha256' => '60780572ab75f716efb03a90ce8d3ccf42d689a3586cbb04b0b25d971fef1dd2',
        'binaries' => ['mysql-community-common-5.7.17-1.el7.x86_64.rpm',
                       'mysql-community-libs-5.7.17-1.el7.x86_64.rpm',
                       'mysql-community-libs-compat-5.7.17-1.el7.x86_64.rpm',
                       'mysql-community-client-5.7.17-1.el7.x86_64.rpm',
                       'mysql-community-server-5.7.17-1.el7.x86_64.rpm']
      }
    }
  elsif node['platform_version'].start_with?("6.")
    force_override['mysql']['archive_names'] = {
      '5.7.17' => {
        'filename' => 'mysql-' + node['mysql']['version'] + '-1.el6.x86_64.rpm-bundle.tar',
        'sha256' => '25dc294ded87bd92f1383b13eeb26c0f6d094e2762ff618a41b14a685727db69',
        'binaries' => ['mysql-community-common-5.7.17-1.el6.x86_64.rpm',
                       'mysql-community-libs-5.7.17-1.el6.x86_64.rpm',
                       'mysql-community-libs-compat-5.7.17-1.el6.x86_64.rpm',
                       'mysql-community-client-5.7.17-1.el6.x86_64.rpm',
                       'mysql-community-server-5.7.17-1.el6.x86_64.rpm']
      }
    }
  end
when 'debian'
  if node['platform'] == 'debian'
    force_override['mysql']['archive_names'] = {
      '5.7.17' => {
        'filename' => 'mysql-server_' + node['mysql']['version'] + '-1debian8_amd64.deb-bundle.tar',
        'sha256' => 'f6bed838adc89d82174c2d84e2b3479bf30fb04df5cf2f9a212ee764bc958039'
      }
    }
  elsif node['platform'] == 'ubuntu'
    if node['platform_version'].split('.').first.to_i == 14
      force_override['mysql']['archive_names'] = {
        '5.7.17' => {
          'filename' => 'mysql-server_' + node['mysql']['version'] + '-1ubuntu14.04_amd64.deb-bundle.tar',
          'sha256' => '134dfbbb02a8ec1d699332f1e5ec5b6867bae1469dc7e1642900f937fcee10ac',
          'binaries' => ['mysql-common_5.7.17-1ubuntu14.04_amd64.deb', 'libmysqlclient20_5.7.17-1ubuntu14.04_amd64.deb', 'libmysqlclient-dev_5.7.17-1ubuntu14.04_amd64.deb', 'mysql-community-client_5.7.17-1ubuntu14.04_amd64.deb', 'mysql-client_5.7.17-1ubuntu14.04_amd64.deb'],
          'server' => ['mysql-community-server_5.7.17-1ubuntu14.04_amd64.deb']
        }
      }
    elsif node['platform_version'].split('.').first.to_i == 16
      force_override['mysql']['archive_names'] = {
        '5.7.17' => {
          'filename' => 'mysql-server_' + node['mysql']['version'] + '-1ubuntu16.10_amd64.deb-bundle.tar',
          'sha256' => '75149649a1d09eb31940bdb8348f0c2027b6985cd7548893f1c4678a038b70c8',
          'binaries' => ['mysql-common_5.7.17-1ubuntu16.10_amd64.deb', 'libmysqlclient20_5.7.17-1ubuntu16.10_amd64.deb', 'libmysqlclient-dev_5.7.17-1ubuntu16.10_amd64.deb', 'libmysqlclient20_5.7.17-1ubuntu16.10_amd64.deb', 'mysql-community-client_5.7.17-1ubuntu16.10_amd64.deb', 'mysql-client_5.7.17-1ubuntu16.10_amd64.deb'],
          'server' => ['mysql-community-server_5.7.17-1ubuntu16.10_amd64.deb']
        }
      }
    end
  end
  force_override['mysql']['prereq_libraries'] = ['libmecab2', 'libaio1']
when 'windows'
  force_override['mysql']['archive_names'] = {
    '5.7.17' => {
      'filename' => 'mysql-' + node['mysql']['version'] + '-winx64.zip',
      'sha256' => '53b2e9eec6d7c986444926dd59ae264d156cea21a1566d37547f3e444c0b80c8'
    }
  }
end

#-------------------------------------------------------------------------------
# MQSQL Configuration
#-------------------------------------------------------------------------------

case node['platform_family']
when 'rhel'
  force_override['mysql']['service_name'] = 'mysqld'
when 'debian'
  if node['platform'] == 'ubuntu'
    if node['platform_version'].split('.').first.to_i == 14
      force_override['mysql']['service_name'] = 'mysql'
    elsif node['platform_version'].split('.').first.to_i == 16
      force_override['mysql']['service_name'] = 'mysql'
    end
  end
end


#-------------------------------------------------------------------------------
# Landscaper compatibility attributes
#-------------------------------------------------------------------------------

# <>  The stack id
default['ibm_internal']['stack_id'] = ''

# <>  The stack name
default['ibm_internal']['stack_name'] = ''

# <>  List of roles on the node
default['ibm_internal']['roles'] = ''

# <>  The vault name for this stack
default['ibm_internal']['vault']['name'] = ''

# <>  The vault item which will contain the secrets
default['ibm_internal']['vault']['item'] = ''


default['mysql']['vault']['name'] = node['ibm_internal']['vault']['name']

# <> ID in the vault that is encrypted. Preferably the root ID, to encrypt everything
default['mysql']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']

#-------------------------------------------------------------------------------
# Secure repo parameters
#-------------------------------------------------------------------------------

# <> self signed certificate TODO make it false
default['ibm']['sw_repo_self_signed_cert'] = 'true'
