########################################################
#	  Copyright IBM Corp. 2012, 2016 
########################################################
# 

actions :create
default_action :create

attribute :lv_name, :kind_of => String
attribute :vg_name, :kind_of => String
attribute :lv_size, :kind_of => String
attribute :filesystem, :kind_of => String
attribute :mountpoint, :kind_of => String
attribute :options, :kind_of => String


