#
# Cookbook Name:: wmq
# Recipe:: start_qmgr
#
# Copyright IBM Corp. 2016, 2017
#
# <> Start all queue managers defined for the target node.


###############################################################################
# START QUEUE MANAGER
###############################################################################

if platform?('redhat') || platform?('ubuntu')
  node['wmq']['qmgr'].each do |_qmgr, qmgrobject|
    execute_start_qmgr(qmgrobject)
  end
end
