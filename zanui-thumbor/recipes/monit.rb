#
# Cookbook Name:: thumbor
# Recipe:: monit
#
# Copyright 2013, Zanui
#
# All rights reserved - Do Not Redistribute
#

template "/etc/monit/conf.d/nginx.monitrc" do
  source 'nginx.monitrc.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[monit]'
  variables({
    :server_port  => node["nginx"]["port"],
  })
end

template "/etc/monit/conf.d/nginx.monitrc" do
  source 'nginx.monitrc.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[monit]'
  variables({
    :server_port  => node["nginx"]["port"],
  })
end

service "monit" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end
