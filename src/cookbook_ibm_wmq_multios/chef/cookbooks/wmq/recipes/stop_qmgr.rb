#
# Cookbook Name:: wmq
# Recipe:: stop_qmgr
#
# Copyright IBM Corp. 2016, 2017
#
# <> Stop all queue managers defined for the target node.


###############################################################################
# STOP QUEUE MANAGER
###############################################################################

if platform?('redhat') || platform?('ubuntu')
  node['wmq']['qmgr'].each do |_qmgr, qmgrobject|
    execute_stop_qmgr(qmgrobject)
  end
end
