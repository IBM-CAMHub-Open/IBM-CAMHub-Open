# encoding: UTF-8
########################################################
#	  Copyright IBM Corp. 2017, 2017
########################################################
#
# Cookbook Name:: ibm_cloud_utils
#

#-------------------------------------------------------------------------------
# Landscaper compatibility attributes
#-------------------------------------------------------------------------------


# <> The URL to the root directory of the HTTPs server hosting the software installation packages i.e. https://<hostname>:<port>
# <md>attribute 'ibm/sw_repo',
# <md>          :displayname =>  'IBM Software Repo Root',
# <md>          :description => 'IBM Software Repo Root (https://<hostname>:<port>)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'pattern',
# <md>          :secret => 'false'
default['ibm']['sw_repo'] = ''

# <> The user that should be used to authenticate on software repository
# <md>attribute 'ibm/sw_repo_user',
# <md>          :displayname =>  'IBM Software Repo Username',
# <md>          :description => 'IBM Software Repo Username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'repouser',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'pattern',
# <md>          :secret => 'false'
default['ibm']['sw_repo_user'] = ''

# <> The password of sw_repo_user
# <md>attribute 'ibm/sw_repo_password',
# <md>          :displayname =>  'IBM Software Repo Password',
# <md>          :description => 'IBM Software Repo Password',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'none',
# <md>          :secret => 'true'
default['ibm']['sw_repo_password'] = ''

# <> the URL to the root directory of the local IM repository (https://<hostname/IP>:<port>/IMRepo)
# <> The user that should be used to authenticate on software repository
# <md>attribute 'ibm/im_repo',
# <md>          :displayname =>  'IBM Software Installation Manager Repository',
# <md>          :description => 'IBM Software  Installation Manager Repository URL (https://<hostname/IP>:<port>/IMRepo) ',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'pattern',
# <md>          :secret => 'false'
default['ibm']['im_repo'] = ''

# <> The user that should be used to authenticate on IM repository
# <md>attribute 'ibm/im_repo_user',
# <md>          :displayname =>  'IBM Software Installation Manager Repository Username',
# <md>          :description => 'IBM Software  Installation Manager Repository username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'repouser',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'pattern',
# <md>          :secret => 'false'
default['ibm']['im_repo_user'] = ''

# <> The password of im_repo_user
# <md>attribute 'ibm/im_repo_password',
# <md>          :displayname =>  'IBM Software Installation Manager Repository Password',
# <md>          :description => 'IBM Software  Installation Manager Repository Password',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'none',
# <md>          :secret => 'true'
default['ibm']['im_repo_password'] = ''

# <> If a secure IM repo is used but it uses a self signed SSL certificate this should be set to "true"
# <md>attribute 'ibm/im_repo_self_signed_cert',
# <md>          :displayname =>  'IBM Software Installation Manager Repository Self Signed Certificate (True/False)',
# <md>          :description => 'IBM Software  Installation Manager Repository Self Signed Certificate (True/False)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'none',
# <md>          :secret => 'false'
default['ibm']['im_repo_self_signed_cert'] = "false"

# <> If a secure Software repo is used but it uses a self signed SSL certificate this should be set to "true"
# <md>attribute 'ibm/sw_repo_self_signed_cert',
# <md>          :displayname =>  'IBM Software Software Repository Self Signed Certificate (True/False)',
# <md>          :description => 'IBM Software  Software Manager Repository Self Signed Certificate (True/False)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'none',
# <md>          :secret => 'false'
default['ibm']['sw_repo_self_signed_cert'] = "false"

# <> If a secure Software repo is used but it uses a self signed SSL certificate this should be set to "true"
# <md>attribute 'ibm/sw_repo_auth',
# <md>          :displayname =>  'IBM Software Software Repository Authentication Enabled',
# <md>          :description => 'IBM Software  Software Manager  Authentication Enabled',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'none',
# <md>          :secret => 'false'
default['ibm']['sw_repo_auth'] = "true"
