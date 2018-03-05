# Cookbook Name:: linux
# Recipe:: attributes/internal
#
# Copyright IBM Corp. 2016, 2017
#

#<> Set the flag to determine whether to skip attributes with INDEX. Set to false to test in a development environment
default['linux']['skip_indexes'] = true

#<> Pre-Reqs for LVM
force_default['linux']['prereqs']['lvm'] = ['lvm2']
