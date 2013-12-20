default[:stackdriver][:api_key] = ''
default[:stackdriver][:config_collectd] = true
default[:stackdriver][:enable] = true
default[:stackdriver][:gpg_key] = 'https://www.stackdriver.com/RPM-GPG-KEY-stackdriver'
case node[:platform]
when 'amazon'
  default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/stackdriver-amazonlinux.repo'
  default[:stackdriver][:config_path] = '/etc/sysconfig/stackdriver'
when 'redhat', 'centos'
  default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/stackdriver.repo'
  default[:stackdriver][:config_path] = '/etc/sysconfig/stackdriver'
when 'ubuntu'
  case node[:platform_version]
  when '10.04'
    default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/apt'
    default[:stackdriver][:repo_dist] = 'lucid'
    default[:stackdriver][:config_path] = '/etc/default/stackdriver-agent'
  when '12.04', '12.10'
    default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/apt'
    default[:stackdriver][:repo_dist] = 'precise'
    default[:stackdriver][:config_path] = '/etc/default/stackdriver-agent'
  end
end
