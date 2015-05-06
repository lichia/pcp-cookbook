default['pcp']['vector']['url'] = 'https://bintray.com/artifact/download/netflixoss/downloads'
default['pcp']['vector']['tgz'] = 'vector.tar.gz'
default['pcp']['vector']['version'] = '1.0.1'
default['pcp']['vector']['checksum'] = 'f4b0e74409ec0fbb60ce30210ff4e39d4c42cd2b190c4ad3340f24d6d9208c0e'
default['pcp']['vector']['nginx_path'] = '/var/www/html/vector'
default['pcp']['nginx']['template'] = 'vector-site.erb'
default['pcp']['nginx']['template_cookbook'] = 'pcp'
default['pcp']['nginx']['fqdn'] = 'vector.coremedia.com'

default['nginx']['default_site_enabled']   = false