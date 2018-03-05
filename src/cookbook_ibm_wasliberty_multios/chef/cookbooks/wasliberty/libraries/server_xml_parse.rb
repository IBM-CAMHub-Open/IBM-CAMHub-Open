########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# <> Module (helpers.rb)
# <> Module with helper functions to compute various liberty editions/settings
#
#########################################################################

# Cookbook Name  - wasliberty
#----------------------------------------------------------------------------------------------------------------------------------------------

# Module with helper functions to parse xml config files
module XMLparse
  require "rexml/document"
  include REXML

  def add_element(fl, search_path, content = nil, attributes = {})
    # Eg:
    #   search_path = "/server/featureManager/feature"
    #   content = "localConnector-1.0"
    #   attributes = {
    #     "attr1": "val1",
    #     "attr2": "val2"
    # }
    # fl = "/var/liberty/usr/servers/my_ctrler/server.xml"

    fdesc = File.new(fl)
    doc = Document.new(fdesc)
    fdesc.close

    # go through the document and look for the element which has
    #   => the same name
    #   => the same content
    # as what we are looking for
    last_found = nil
    doc.elements.each(search_path) do |elem|
      last_found = elem if elem.text == content
      # go until the last one, of the possible several....
    end

    if last_found # if the element exists with the required content, enforce the attributes
      attributes.each do |k, v|
        last_found.add_attribute(k.to_s, v)
      end
    else # if element with the required content not found:
      # prepare the element to be added with the required content and attributes
      all_nodes = search_path.split("/").reject(&:empty?)
      parent_nodes = all_nodes[0...-1]
      leaf = all_nodes[-1]

      new_elem = Element.new(leaf)
      new_elem.text = content
      attributes.each do |k, v|
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

    fdesc = File.open(fl, "w")
    doc.write(fdesc)
    fdesc.close
  end
  Chef::Recipe.send(:include, XMLparse)
  Chef::Resource.send(:include, XMLparse)
end
