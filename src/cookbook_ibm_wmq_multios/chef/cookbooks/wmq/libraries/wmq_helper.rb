# Cookbook Name:: wmq
# Library:: wmq_helper
#
# Copyright IBM Corp. 2016, 2017
#
# <> library: WMQ Helper
# <> Library Functions for the WMQ cookbook

# <> library: WMQHelper
# <> Library Functions for the WMQ Cookbook
module WMQHelper
  # Helper functions for WMQ cookbook
  include Chef::Mixin::ShellOut

  def wmq_installed?
    #Returns whether MQSeries is installed or not
    run_cmd = 'rpm -qa | grep -i SeriesRuntime | grep -v grep'
    output = shell_out(run_cmd)
    !output.stdout.to_s.empty?
  end

  def wmq_upgrade_fixpack?
    #Returns a boolean depending on whether a fixpack upgrade is needed or not
    run_cmd = node['wmq']['install_dir'] + '/bin/dspmqver | grep Version'
    output = shell_out(run_cmd)
    current_fixpack = output.stdout.split('.')[-1]
    required_fixpack = node['wmq']['fixpack']
    required_fixpack > current_fixpack
  end
end

Chef::Recipe.send(:include, WMQHelper)
Chef::Resource.send(:include, WMQHelper)

