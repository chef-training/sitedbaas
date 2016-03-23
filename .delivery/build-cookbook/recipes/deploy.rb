#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
search_terms = []
get_all_project_cookbooks.each do |cookbook|
  search_terms << "recipes:#{cookbook.name}*"
end

unless search_terms.empty?
  search_query = "(#{search_terms.join(' OR ')}) " \
                 "AND chef_environment:#{delivery_environment} " \
                 "AND os:linux " \
                 "AND #{deployment_search_query}"

  my_nodes = delivery_chef_server_search(:node, search_query)

  my_nodes.map!(&:name)

  delivery_push_job "deploy_#{node['delivery']['change']['project']}" do
    command 'chef-client'
    nodes my_nodes
  end
end
