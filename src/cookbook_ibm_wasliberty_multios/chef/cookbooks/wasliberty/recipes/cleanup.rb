########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# recipe to remove the expand_area / tmp folders from a provisioned machine
# <> Cleanup recipe (cleanup.rb)
# <> Cleanup recipe removes the folders, where binaries extracted
#

log "Cleanup #{node['was_liberty']['expand_area']}"
directory node['was_liberty']['expand_area'] do
  recursive true
  action :delete
end
