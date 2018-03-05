# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2016
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
require 'chef/resource/powershell_script'
# include Chef::Provider::PowershellScript

use_inline_resources

def whyrun_supported?
    true
end

action :run do
    if RUBY_PLATFORM =~ /win|mingw/
        Chef::Log.debug("DEBUG: Incrementing Size of Pagefile by #{new_resource.increment_size} MB")
        powershell_script 'Increment-Pagefile-Size' do
            code <<-EOH
            $computersys = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges;
            $physicalmem = Get-WmiObject Win32_PhysicalMemory;
            $ram = [int]($physicalmem.Capacity/1024/1024);
            $computersys.AutomaticManagedPagefile = $False;
            $computersys.Put();
            $pagefile = Get-WmiObject -Query "Select * From Win32_PageFileSetting Where Name like '%pagefile.sys'";
            $pagefile.InitialSize = [int]$ram + #{new_resource.increment_size}; # new_resource.attributeName
            $pagefile.MaximumSize = [int]$ram + #{new_resource.increment_size};
            $pagefile.Put();
            EOH
        end
        new_resource.updated_by_last_action(true)
    else
        Chef::Log.debug("DEBUG: Not a Supported Operating System")
    end
end
