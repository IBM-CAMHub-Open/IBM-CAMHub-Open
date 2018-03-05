#
# Cookbook Name:: ibm_cloud_utils
# Provider:: enable_awsyumrepo
#
# Copyright IBM Corp. 2017, 2017
#

include IBM::IBMHelper

use_inline_resources

def whyrun_supported?
  true
end

action :enable do
  def_aws_yumsetup
end

def def_aws_yumsetup
  execute 'enable-extra-repository' do
    command 'yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional'
    only_if { IBM::IBMHelper.awscloud? }
    only_if { node['platform_family'] == "rhel" }
  end
end
