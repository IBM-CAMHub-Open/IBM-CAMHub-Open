########################################################
#	  Copyright IBM Corp. 2017, 2017 
########################################################
# 

actions :create, :remove, :enable, :disable
default_action :create

attribute :swapfile, :kind_of => String, :default => '/swapfile.swp'
attribute :size, :kind_of => String
attribute :label, :kind_of => String
attribute :force, :kind_of => [TrueClass, FalseClass], :default => false
