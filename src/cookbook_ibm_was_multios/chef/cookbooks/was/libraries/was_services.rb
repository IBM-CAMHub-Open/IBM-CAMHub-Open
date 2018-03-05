# Cookbook Name:: was
# Library:: was_services
#
# Copyright IBM Corp. 2016, 2017
#

# <> library: WAS services
# <> Library Functions for the WAS Cookbook
module WASServices
  # Helper functions for WAS cookbook
  include Chef::Mixin::ShellOut


  def was_service(svc)
    service svc do
      action [:enable, :start]
      supports [:restart, :status]
    end
  end

  def start_dmgr
    svc = "#{was_tags((node['was']['profiles']['dmgr']['node']).to_s)}_was.init"
    was_service(svc)
  end

  def stop_nodeagent
    svc = "#{was_tags((node['was']['profiles']['node_profile']['node']).to_s)}_was.init"
    service svc do
      action [:enable, :stop]
      supports [:restart, :status, :start]
    end
  end

  def start_nodeagent
    svc = "#{was_tags((node['was']['profiles']['node_profile']['node']).to_s)}_was.init"
    service svc do
      action [:enable, :start]
      supports [:restart, :status, :stop]
    end
  end

  def start_server(server)
    svc = "#{was_tags(server)}_was.init"
    service svc do
      action [:enable, :start]
      supports [:restart, :status, :stop]
    end
  end

  def stop_server(server)
    svc = "#{was_tags(server)}_was.init"
    service svc do
      action [:enable, :stop]
      supports [:restart, :status, :start]
    end
  end
end

Chef::Recipe.send(:include, WASServices)
Chef::Resource.send(:include, WASServices)
