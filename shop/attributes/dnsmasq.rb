#
# Copyright 2013, Zanui <engineering@zanui.com.au>
#
# All rights reserved - Do Not Redistribute
#

include_attribute 'dnsmasq'

default[:dnsmasq][:dns] = {
  'resolv-file' => '/etc/resolv.dnsmasq.conf'
}
default[:dnsmasq][:nameservers] = ['127.0.0.1']
