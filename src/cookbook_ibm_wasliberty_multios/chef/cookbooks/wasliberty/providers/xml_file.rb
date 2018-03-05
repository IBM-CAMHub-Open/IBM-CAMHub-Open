########################################################
# Copyright IBM Corp. 2016, 2017
########################################################
#
# Cookbook Name:: wasliberty
###############################################################################

use_inline_resources

require "rexml/document"
include REXML

action :add_element do
  # Eg:
  #   search_path = "/server/featureManager/feature"
  #   new_resource.content = "localConnector-1.0"
  #   new_resource.attributes = {
  #     "attr1": "val1",
  #     "attr2": "val2"
  # }
  # fl = "/var/liberty/usr/servers/my_ctrler/server.xml"

  fdesc = ::File.new(new_resource.source, 'r')
  doc = Document.new(fdesc)
  fdesc.close

  # go through the document and look for the element which has
  #   => the same name
  #   => the same new_resource.content
  # as what we are looking for
  last_found = false
  modified = false
  doc.elements.each(new_resource.search_path) do |elem|
    last_found = elem if elem.text == new_resource.content
    # go until the last one, of the possible several....
  end

  if last_found # if the element exists with the required content, enforce the attributes
    new_resource.node_attrs.each do |k, v|
      Chef::Log.info "Enforcing: #{k} => #{v}"
      next if last_found.attributes.key?(k) && last_found.attributes[k].to_s == v.to_s
      last_found.add_attribute(k.to_s, v.to_s)
      Chef::Log.info "Added #{k} => #{v}"
      modified = true
    end
  else # if element with the required content not found:
    # prepare the element to be added with the required content and new attributes
    modified = true
    all_nodes = new_resource.search_path.split("/").reject(&:empty?)
    parent_nodes = all_nodes[0...-1]
    leaf = all_nodes[-1]

    new_elem = Element.new(leaf)
    new_elem.text = new_resource.content
    new_resource.node_attrs.each do |k, v|
      new_elem.add_attribute(k.to_s, v)
    end

    # create all the required parent nodes (if needed)
    crt_node = doc
    parent_nodes.each do |elem|
      crt_node.add_element(Element.new(elem)) unless crt_node.elements[elem]
      crt_node = crt_node.elements[elem]
    end

    # add the new element
    crt_node.add_element(new_elem)
  end

  if modified
    fdesc = ::File.open(new_resource.source, 'w')
    doc.write(fdesc)
    fdesc.close
    new_resource.updated_by_last_action(true)
  else
    new_resource.updated_by_last_action(false)
  end
end
