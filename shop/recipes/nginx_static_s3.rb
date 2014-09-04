#
# Cookbook Name:: shop
# Recipe:: nginx_static_s3
#
# Copyright 2013, Zanui
#
# All rights reserved - Do Not Redistribute
#

template "#{node['nginx']['dir']}/sites-available/shop_static_s3" do
  source 'shop_static_s3.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
  variables({
    :server_port => node['shop']['static_s3']['nginx']['port'],
    :server_name => node['shop']['static_s3']['nginx']['server_name'],

    :static_host => node['shop']['static_s3']['nginx']['static_host'],
    :static_fallback_enabled => node['shop']['static_s3']['nginx']['static_fallback']['enabled'],
    :static_fallback_host => node['shop']['static_s3']['nginx']['static_fallback']['host'],

    :s3_region => node['shop']['static_s3']['nginx']['s3_region'],
    :s3_bucket => node['shop']['static_s3']['nginx']['s3_bucket'],
    :s3_media_base_dir => node['shop']['static_s3']['nginx']['s3_media_base_dir'],

    :proxy_cache_enabled  => node['shop']['static_s3']['nginx']['proxy_cache']['enabled'],
    :proxy_cache_path     => node['shop']['static_s3']['nginx']['proxy_cache']['path'],
    :proxy_cache_key_zone => node['shop']['static_s3']['nginx']['proxy_cache']['key_zone']
  })
end

nginx_site 'shop_static_s3'

template "#{node['nginx']['dir']}/sites-available/shop_static_staging_s3" do
  source 'shop_static_s3.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
  variables({
    :env => 'staging',

    :server_port => node['shop']['static_staging_s3']['nginx']['port'],
    :server_name => node['shop']['static_staging_s3']['nginx']['server_name'],

    :static_host => node['shop']['static_staging_s3']['nginx']['static_host'],
    :static_fallback_enabled => node['shop']['static_staging_s3']['nginx']['static_fallback']['enabled'],
    :static_fallback_host => node['shop']['static_staging_s3']['nginx']['static_fallback']['host'],


    :s3_region => node['shop']['static_staging_s3']['nginx']['s3_region'],
    :s3_bucket => node['shop']['static_staging_s3']['nginx']['s3_bucket'],
    :s3_media_base_dir => node['shop']['static_staging_s3']['nginx']['s3_media_base_dir'],

    :proxy_cache_enabled  => node['shop']['static_staging_s3']['nginx']['proxy_cache']['enabled'],
    :proxy_cache_path     => node['shop']['static_staging_s3']['nginx']['proxy_cache']['path'],
    :proxy_cache_key_zone => node['shop']['static_staging_s3']['nginx']['proxy_cache']['key_zone']
  })
end

nginx_site 'shop_static_staging_s3'
