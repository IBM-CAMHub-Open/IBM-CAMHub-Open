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

action :zip do
    if RUBY_PLATFORM =~ /win|mingw/
        Chef::Log.debug("DEBUG: Zipping on Windows #{new_resource.target_zip} to #{new_resource.source}...")
        powershell_script 'zip with powershell' do
            code <<-EOH
            function Add-Zip
            {
                param([string]$zipfilename)

                if(-not (test-path($zipfilename)))
                {
                    set-content $zipfilename ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
                    (dir $zipfilename).IsReadOnly = $false
                }

                $shellApplication = new-object -com shell.application
                $zipPackage = $shellApplication.NameSpace($zipfilename)

                foreach($file in $input)
                {
            $zipPackage.CopyHere($file.FullName, 1564)
            Start-sleep 10
                }
            }

            $zipfilename = [System.IO.Path]::GetFullPath('#{new_resource.target_zip}')
            $tempTarget = '#{new_resource.source}'

            If ($tempTarget.endswith('*.*')){
                $target = $tempTarget.Replace('*.*', '')
                $target = [System.IO.Path]::GetFullPath($target)
                $target = $target + '*.*'
            }

            Else{
                $target = [System.IO.Path]::GetFullPath($tempTarget)
            }

            If (Test-Path $zipfilename){
              Remove-Item $zipfilename
            }

            dir $target -Recurse | add-Zip $zipfilename
            EOH
        end
    else
        Chef::Log.debug("DEBUG: Zipping on Unix #{new_resource.target_zip} to #{new_resource.source}...")
        execute "zip files" do
            command "zip -r #{new_resource.target_zip} #{new_resource.source}"
        end
    end
    new_resource.updated_by_last_action(true)
end
