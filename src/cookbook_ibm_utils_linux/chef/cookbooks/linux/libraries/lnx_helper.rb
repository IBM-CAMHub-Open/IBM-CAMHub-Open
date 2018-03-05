# Cookbook Name:: ihs
# Library:: ihs_helper
#
# Copyright IBM Corp. 2016, 2017
#

# <> library: IHS helper
# <> Library Functions for the IHS Cookbook
module LNXHelper
  # Helper functions for IHS cookbook
  include Chef::Mixin::ShellOut

  # is disk a raw volume?
  def raw_volume?(disk)
    shell_out("lsblk -nflo FSTYPE /dev/#{disk}").stdout.strip.empty?
  end
end
