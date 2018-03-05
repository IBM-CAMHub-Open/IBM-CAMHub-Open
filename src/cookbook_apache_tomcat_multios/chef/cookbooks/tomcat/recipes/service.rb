################################################################################
# Copyright IBM Corp. 2017, 2017
################################################################################

# <> Service setup recipe (service.rb)
# <> Configure tomcat service

actions = []
node['tomcat']['service']['enabled'].casecmp('true') == 0 ? actions.push(:enable) : actions.push(:disable)
node['tomcat']['service']['started'].casecmp('true') == 0 ? actions.push(:start) : actions.push(:stop)

service node['tomcat']['service']['name'] do
  action actions
  supports [:restart, :status]
end
