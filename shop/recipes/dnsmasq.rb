#
# Cookbook Name:: shop
# Recipe:: dnsmasq
#
# Copyright 2013, Zanui
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'dnsmasq'

template '/etc/resolv.dnsmasq.conf' do
  source 'resolv.dnsmasq.conf.erb'
  mode 0644
  variables(
    :nameservers => node['dnsmasq']['nameservers']
  )
  notifies :restart, resources(:service => 'dnsmasq'), :immediately
end
