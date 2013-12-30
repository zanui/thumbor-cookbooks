#
# Copyright 2013, Zanui <engineering@zanui.com.au>
#
# All rights reserved - Do Not Redistribute
#

default['shop']['static_s3']['nginx']['port'] = 80
default['shop']['static_s3']['nginx']['proxy_cache']['enabled'] = false
default['shop']['static_s3']['nginx']['proxy_cache']['path'] = '/var/www/static_s3_cache'
default['shop']['static_s3']['nginx']['proxy_cache']['key_zone'] = 'static_s3_cache'

default['shop']['static_s3']['nginx']['server_name'] = 'static-s3.zanui.com.au'
default['shop']['static_s3']['nginx']['s3_region'] = 'ap-southeast-2'
default['shop']['static_s3']['nginx']['s3_bucket'] = 'zanui-shop-data-live'
