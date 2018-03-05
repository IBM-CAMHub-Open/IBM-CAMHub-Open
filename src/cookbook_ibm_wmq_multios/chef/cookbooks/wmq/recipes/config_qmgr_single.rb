#
# Cookbook Name:: wmq
# Recipe:: config_qmgr_single
#
# Copyright IBM Corp. 2016, 2017
#
# <> Create one or more queue managers if they do not already exist.


###############################################################################
# CREATE QUEUE MANAGER
###############################################################################

if platform?('redhat') || platform?('ubuntu')
  node['wmq']['qmgr'].each do |qmgr, qmgrobject|
    next if qmgr.match('$INDEX') && node['wqm']['skip_indexes']
    execute_create_qmgr(qmgrobject)
  end
end
