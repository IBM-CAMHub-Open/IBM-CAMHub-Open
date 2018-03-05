########################################################
#
# Cookbook Name:: oracledb
# attributes :: internal
#
# Copyright IBM Corp. 2017, 2017
#
########################################################

# <> internal attributes (internal.rb)
# <> attributes that are not supposed to be exposed.

############################################################################################################
# STANDARD Environemnt Settings
############################################################################################################

# <> The URL to the root directory of the HTTP server hosting the software installation packages i.e. http://<hostname>:<port>
default['ibm']['sw_repo'] = ''

default['ibm']['sw_repo_user'] = ''

default['ibm']['debug_mode'] = true

# <> Oracle Base Directory
# /mount_point/app/software_owner
#  -- mount_point    = node['oracledb']['data_mount']
#  -- software_owner = node['oracledb']['os_users']['oracle']['name']
default['oracledb']['oracle_base'] = node['oracledb']['data_mount'] + '/app/' + node['oracledb']['os_users']['oracle']['name']

# <> Oracle Database Inventory Directory
default['oracledb']['db_ora_inventory'] = node['oracledb']['data_mount'] + '/app/database-oraInventory'

# <> Oracle Grid Inventory Directory
default['oracledb']['grid_ora_inventory'] = node['oracledb']['data_mount'] + '/grid-oraInventory'

# <> Oracle SID uppercase
force_default['oracledb']['SID'] = node['oracledb']['SID'].upcase

# <> Additional groups
# <md>attribute 'oracle/groups',
# <md>          :displayname => 'Additional OS groups',
# <md>          :description => 'Additional OS groups',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => [ 'oinstall', 'dba', 'oper', 'asmdba', 'asmoper', 'asmadmin', 'racdba' ],
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['groups'] = %w(dba oper asmdba asmoper asmadmin racdba)
# TODO Need to check if all the groups are really needed espicially oper asmdba asmoper asmadmin racdba
# ^^ Source for above groups -- https://docs.oracle.com/database/121/LADBI/usr_grps.htm#LADBI7676
default['oracledb']['dba_group'] = 'dba'

# <> Local Export Directory
# default['oracledb']['export_dir'] = node['oracledb']['oracle_base'] + '/' + node['oracledb']['SID'] + '/export' # TODO - Check the necessity one more time

# <> Oracle Database Release
default['oracledb']['release'] = node['oracledb']['release_patchset'].split('.')[0..2].join('.')

# <> Oracle install archive_names zip files
case node['platform_family']
when 'rhel'
  case node['oracledb']['version']
  when 'v12c'
    case node['oracledb']['release_patchset']
    when '12.2.0.1.0' # ~ip_checker
      default['oracledb']['database']['archive_names'] = {
        '1' => { 'filename' => 'V839960-01.zip', 'sha256' => '12598250BE536C9D074AE0EB2F7DF4A9B463D0EB' }
      }
      default['oracledb']['grid']['archive_names'] = {
        '1' => { 'filename' => 'V840012-01.zip', 'sha256' => 'F4611B73B502A2BD560E5788BE168E306D7A4BDA' }
      }
    when '12.1.0.2.0' # ~ip_checker
      default['oracledb']['database']['archive_names'] = {
        '1' => { 'filename' => 'V46095-01_1of2.zip', 'sha256' => 'E378379735301E2B87A812803B59475B9DA8F36C' },
        '2' => { 'filename' => 'V46095-01_2of2.zip', 'sha256' => 'FEFC5B984E139ED08DD0C54105BAE2CA297AA26C' }
      }
      default['oracledb']['grid']['archive_names'] = {
        '1' => { 'filename' => 'V46096-01_1of2.zip', 'sha256' => '32C045F3E673147A7ACE78222DF8A26C900AB8E6' },
        '2' => { 'filename' => 'V46096-01_2of2.zip', 'sha256' => 'D74DB40E7187E426E47CC5512DAE1855E44027CD' }
      }
    when '12.1.0.1.0' # ~ip_checker
      default['oracledb']['database']['archive_names'] = {
        '1' => { 'filename' => 'V38500-01_1of2.zip', 'sha256' => '1821357C86705ADA97E30A7A1700B73E9CAE81A0' },
        '2' => { 'filename' => 'V38500-01_2of2.zip', 'sha256' => '16098684F9C395890C49D1F17660AD453D7825A0' }
      }
      default['oracledb']['grid']['archive_names'] = {
        '1' => { 'filename' => 'V38501-01_1of2.zip', 'sha256' => 'A780EB69F1507D4CD6C3D3D0A8309BE4559781D7' },
        '2' => { 'filename' => 'V38501-01_2of2.zip', 'sha256' => '515BFDAC059B4325C23B9EED0126FA947BE7E52F' }
      }
    end
  when 'v11g'
  when 'v10g'
  when 'v9i'
  end
when 'windows'
end

# <> Oracle database and maint directories (based on ibm repo location)

force_default['oracledb']['sw_repo_path']['base'] = node['ibm']['sw_repo'] + '/oracle/ee/' + node['oracledb']['version'] + '/base'
#force_default['oracledb']['sw_repo_path']['maint'] = node['ibm']['sw_repo'] + '/oracle/database/v12c/maint'

# <> Install platform ID
force_default['oracledb']['platform_id'] = '46'

if node['oracledb']['version'] == 'v12c'
    # <> Oracle grid home directory
    force_default['oracledb']['ora_grid_home'] = "#{node['oracledb']['oracle_base']}/product/#{node['oracledb']['release']}/grid"

    # <> Oracle database home directory
    force_default['oracledb']['oracle_home'] = "#{node['oracledb']['oracle_base']}/product/#{node['oracledb']['release']}/dbhome_1"
end

# <> OS Environment Variables and PATH
force_default['oracledb']['env'] = { 'ORACLE_BASE' => node['oracledb']['oracle_base'],
                                     'ORACLE_HOME' => node['oracledb']['oracle_home'],
                                     'DB_UNIQUE_NAME' => node['oracledb']['SID'] }

#############################################################################
# ORACLE KERNEL ATTRIBUTES
# User-tunable attributes, and Oracle recommended MINIMUM values for all versions of Oracle
#############################################################################
# <> oracle database process id
force_default['oracledb']['processes'] = '240'

# <> kernel small attribute
force_default['oracledb']['kernel']['shmall'] = '209_715_2'

# <> kernel shmmni attribute
force_default['oracledb']['kernel']['shmmni'] = '409_6'

# <> net core rmem default
force_default['oracledb']['net']['core']['rmem_default'] = '262_144'

# <> net core wmeme default
force_default['oracledb']['net']['core']['wmem_default'] = '262_144'

#############################################################################
# User-tunable attribues, and Oracle recommended MINIMUM values for 11g version of Oracle
#############################################################################
# <> fs file max
force_default['oracledb']['fs']['file_max'] = '681_574_4'

# <> fs aio max nr
force_default['oracledb']['fs']['aio_max_nr'] = '104_857_6'

# <> net ipv4 ip local port range
force_default['oracledb']['net']['ipv4']['ip_local_port_range'] = '9000 65500'

# <> net core rmem max
force_default['oracledb']['net']['core']['rmem_max'] = '419_430_4'

# <> net core wmem max
force_default['oracledb']['net']['core']['wmem_max'] = '104_857_6'

#############################################################################
# Values below are calculated:  4Gb of RAM expressed in Kb
#############################################################################

# <> memory required
memory_fourgb = '419_430_4'

#############################################################################
# Calculated semaphore settings in accordance with Oracle documentation
#############################################################################

# <> kernel semmsl
force_default['oracledb']['kernel']['semmsl'] = node['oracledb']['processes'].to_i + 10

# <> kernel semmni
force_default['oracledb']['kernel']['semmni'] = '128'

# <> kernel semmns
force_default['oracledb']['kernel']['semmns'] = node['oracledb']['kernel']['semmsl'].to_i * node['kernel']['semmni'].to_i

# <> kernel semopm
force_default['oracledb']['kernel']['semopm'] = node['oracledb']['kernel']['semmsl']

#############################################################################
# Calculated shmmax by architecture and amount of RAM
#############################################################################
# <> Calculated shmmax by architecture and amount of RAM
if node['kernel']['machine'] =~ /^(x|i[3456])86$/i
  # Set shmmax to lower of 2350000000, or half of memory.
  force_default['kernel']['shmmax'] = if node['memory']['total'].to_i > memory_fourgb
                                   300_000_000_0
                                      else
                                   ((node['memory']['total'].to_i * 1024) / 2)
                                      end
  force_default['oracledb']['file_mapping_utility_path'] = '/opt/ORCLfmap/prot1_64/bin/fmputl'
elsif node['kernel']['machine'] =~ /^(x86_|amd)64$/i
  # Set shmmax to half of memory.
  force_default['kernel']['shmmax'] = ((node['memory']['total'].to_i * 1024) / 2)
  force_default['oracledb']['file_mapping_utility_path'] = '/opt/ORCLfmap/prot1_64/bin/fmputl'
end

# <> swap file
force_default['oracledb']['swap_file'] = '/swap.image'

force_default['oracledb']['user_limits_conf_file_path'] = '/etc/security/limits.d/oracle.conf'

case node['platform_family']
when 'rhel'
  # <> Location where Temporary files are created / store
  default['ibm']['temp_dir'] = '/tmp/ibm_cloud'
  # <> Location where Evidence files are stored
  default['ibm']['log_dir'] = '/var/log/ibm_cloud'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '/expand_area'
  # <> An absolute path to a directory that will be used to store the evidence file created as part of the automation
  default['ibm']['evidence_path'] = node['ibm']['log_dir'] + '/evidence/--cookbook_name--'
  # <> cookbook expand area
  force_default['oracledb']['expand_area'] = node['ibm']['expand_area'] + '/--cookbook_name--'
  # <> The name of the artifacts archive
  default['ibm']['evidence_file'] = "#{node['ibm']['evidence_path']}/--cookbook_name---#{node['hostname']}.tar"
  # <> The name of the log file for gathered evidence
  default['ibm']['evidence_log'] = "--cookbook_name---#{node['hostname']}.log"
  platform_version = node['platform_version'].to_f
  if platform_version >= 6 && platform_version < 7
    # Red Hat Enterprise Linux 6: 2.6.32-71.el6.x86_64 or later
    default['oracledb']['asm']['oracleasm-support'] = node['ibm']['sw_repo'] + 'oracleasm-support/oracleasm-support-2.1.8-1.el6.x86_64.rpm'
    default['oracledb']['asm']['oracleasmlib']      = node['ibm']['sw_repo'] + 'oracleasmlib/oracleasmlib-2.0.4-1.el6.x86_64.rpm'
    force_default['oracledb']['os_libraries'] = [ 'binutils', 'compat-libcap1.x86_64', 'compat-libstdc++-33', 'gcc', 'gcc-c++', 'glibc', 'glibc-devel', 'ksh', 'libgcc', 'libstdc++', 'libstdc++-devel', 'libaio', 'libaio-devel', 'libXext', 'libXtst', 'libX11', 'libXau', 'libxcb', 'libXi', 'make', 'sysstat', 'unzip', 'net-tools' ]
  elsif platform_version >= 7
    # Red Hat Enterprise Linux 7: 3.10.0-123.el7.x86_64 or later
    force_default['oracledb']['os_libraries'] = [ 'binutils', 'compat-libcap1.x86_64', 'compat-libstdc++-33', 'gcc', 'gcc-c++', 'glibc', 'glibc-devel', 'ksh', 'libgcc', 'libstdc++', 'libstdc++-devel', 'libaio', 'libaio-devel',            'libXtst',                               'libXi', 'make', 'sysstat', 'unzip', 'net-tools' ]
    default['oracledb']['asm']['oracleasm-support'] = node['ibm']['sw_repo'] + 'oracleasm-support/oracleasm-support-2.1.8-3.el7.x86_64.rpm'
    default['oracledb']['asm']['oracleasmlib']      = node['ibm']['sw_repo'] + 'oracleasmlib/oracleasmlib-2.0.12-1.el7.x86_64.rpm'
  end
when 'windows'
  # <> An absolute path to a directory that will be used to hold any temporary files created as part of the automation
  default['ibm']['temp_dir'] = 'C:\\temp\\ibm_cloud'
  # <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
  default['ibm']['log_dir'] = 'C:\\temp\\ibm_cloud\\log'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '\\expand_area'
end

if node['oracledb']['ASM_install'] == 'true'
  # <> OS software dependencies for installing oracle with ASM
  force_default['oracledb']['os_libraries'] = force_default['oracledb']['os_libraries'] + [ 'kmod-oracleasm', 'libcap.x86_64' ]
end

#==================================================================================================================================
# Pre Req Packages
# Source :: https://docs.oracle.com/database/121/LADBI/pre_install.htm#LADBI7534
#==================================================================================================================================
# Library Name for RHEL6                  - Library Name for RHEL7
#==================================================================================================================================
# binutils-2.23.52.0.1-12.el7.x86_64      - binutils-2.20.51.0.2-5.11.el6 (x86_64)    - 'binutils',
# compat-libcap1-1.10-3.el7.x86_64        - compat-libcap1-1.10-1 (x86_64)            - 'compat-libcap1.x86_64',
# compat-libstdc++-33-3.2.3-71.el7.x86_64 - compat-libstdc++-33-3.2.3-69.el6 (x86_64) - 'compat-libstdc++-33',
# gcc-4.8.2-3.el7.x86_64                  - gcc-4.4.4-13.el6 (x86_64)                 - 'gcc',
# gcc-c++-4.8.2-3.el7.x86_64              - gcc-c++-4.4.4-13.el6 (x86_64)             - 'gcc-c++',
# glibc-2.17-36.el7.i686                  - glibc-2.12-1.7.el6 (x86_64)               - 'glibc',
# glibc-devel-2.17-36.el7.x86_64          - glibc-devel-2.12-1.7.el6 (x86_64)         - 'glibc-devel',
# ksh                                     - ksh                                       - 'ksh',
# libgcc-4.8.2-3.el7.x86_64               - libgcc-4.4.4-13.el6 (x86_64)              - 'libgcc',
# libstdc++-4.8.2-3.el7.x86_64            - libstdc++-4.4.4-13.el6 (x86_64)           - 'libstdc++',
# libstdc++-devel-4.8.2-3.el7.x86_64      - libstdc++-devel-4.4.4-13.el6 (x86_64)     - 'libstdc++-devel',
# libaio-0.3.109-9.el7.x86_64             - libaio-0.3.107-10.el6 (x86_64)            - 'libaio',
# libaio-devel-0.3.109-9.el7.x86_64       - libaio-devel-0.3.107-10.el6 (x86_64)      - 'libaio-devel',
# libXext-1.1 (x86_64)                                                                - 'libXext',
# libXtst-1.2.2-1.el7.x86_64              - libXtst-1.0.99.2 (x86_64)                 - 'libXtst',
# libX11-1.3 (x86_64)                                                                 - 'libX11',
# libXau-1.0.5 (x86_64)                                                               - 'libXau',
# libxcb-1.5 (x86_64)                                                                 - 'libxcb',
# libXi-1.7.2-1.el7.x86_64                - libXi-1.3 (x86_64)                        - 'libXi',
# make-3.82-19.el7.x86_64                 - make-3.81-19.el6                          - 'make',
# sysstat-10.1.5-1.el7.x86_64             - sysstat-9.0.4-11.el6 (x86_64)             - 'sysstat',
# TODO - See below libraries are needed
# 'kmod-oracleasm',
# 'libcap.x86_64'
# 'glibc-common',
# 'glibc-headers',
#libXmu
#libXt
#libXv
#libXxf86dga
#libdmx
#libXxf86misc
#libXxf86vm
#xorg-x11-utils
#xorg-x11-xauth
#==================================================================================================================================

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
default['oracledb']['vault']['name'] = node['ibm_internal']['vault']['name']

# <>  The vault item which will contain the secrets
default['ibm_internal']['vault']['item'] = ''
default['oracledb']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']

# <> If a secure Software repo is used but it uses a self signed SSL certificate this should be set to "true"
default['ibm']['sw_repo_self_signed_cert'] = "false"

########################################################
# ASM Settings  #TODO - Unused attributes at this moment
########################################################

# <> Installation check with ASM or with local FS
# <md>attribute 'oracle/version',
# <md>          :displayname =>  'Database Version',
# <md>          :description => 'Database Version',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :choice => [ 'v12c' ]
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['asm']['ASM_install'] = 'false'

# <> ASM INstallation log directory
# <md>attribute 'oracle/version',
# <md>          :displayname =>  'Database Version',
# <md>          :description => 'Database Version',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :choice => [ 'v12c' ]
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['asm']['log'] = "#{node['ibm']['temp_dir']}/asm.log"

# <> ASM Instance name
# <md>attribute 'oracle/version',
# <md>          :displayname =>  'Database Version',
# <md>          :description => 'Database Version',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :choice => [ 'v12c' ]
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['asm']['SID'] = '+ASM1'

# <> Location of the ASM disks
# <md>attribute 'oracle/version',
# <md>          :displayname =>  'Database Version',
# <md>          :description => 'Database Version',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :choice => [ 'v12c' ]
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['asm']['basedir'] = '/dev/oracleasm/disks'

# <> Oracle ASM redundancy value set
# <md>attribute 'oracle/version',
# <md>          :displayname =>  'Database Version',
# <md>          :description => 'Database Version',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :choice => [ 'v12c' ]
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['asm']['asm_redundancy'] = 'EXTERNAL'

# <> DiskVolume name for volume FRA
# <md>attribute 'oracle/version',
# <md>          :displayname =>  'Database Version',
# <md>          :description => 'Database Version',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :choice => [ 'v12c' ]
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['asm']['DiskVolName_FRA'] = 'DG' + node['oracledb']['SID'] + '_FRA'

# <> DiskVolume name for volume DATA
# <md>attribute 'oracle/version',
# <md>          :displayname =>  'Database Version',
# <md>          :description => 'Database Version',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :choice => [ 'v12c' ]
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['asm']['DiskVolName_DATA'] = 'DG' + node['oracledb']['SID'] + '_DATA'

# <> ASM check on / off used in rsp for setting the instalation type
# <md>attribute 'oracle/version',
# <md>          :displayname =>  'Database Version',
# <md>          :description => 'Database Version',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :choice => [ 'v12c' ]
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['database']['ora_storage_type'] = 'ASM_STORAGE'
default['oracledb']['database']['ora_storage_typedb'] = 'ASM'

# <> ASM user service password
# <md>attribute 'oracle/version',
# <md>          :displayname =>  'Database Version',
# <md>          :description => 'Database Version',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :choice => [ 'v12c' ]
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['asm']['asmsnmpPassword'] = ''

# <> Oracle ASM system password
# <md>attribute 'oracle/version',
# <md>          :displayname =>  'Database Version',
# <md>          :description => 'Database Version',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :choice => [ 'v12c' ]
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['asm']['sysAsmPassword'] = ''
# ASM Storage Disks

# <> Arrays containing disks used by ASM
# <md>attribute 'oracle/version',
# <md>          :displayname =>  'Database Version',
# <md>          :description => 'Database Version',
# <md>          :type => 'string',
# <md>          :required => 'required',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :choice => [ 'v12c' ]
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['asm']['crs_diskpartitions']  = { "CRSDISK1"  => "/dev/vdb1" } # '/dev/sdc1/part1'
default['oracledb']['asm']['fra_diskpartitions']  = { "FRADISK1"  => "/dev/vdc1" } # '/dev/sdd1/part1'
default['oracledb']['asm']['data_diskpartitions'] = { "DATADISK1" => "/dev/vdd1" } # '/dev/sde1/part1'

default['oracledb']['asm']['oracleasm-support'] = ''
default['oracledb']['asm']['oracleasmlib']      = ''
