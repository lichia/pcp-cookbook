=begin
#<
This recipe installs netflix vector and nginx packages.
#>
=end

include_recipe 'nginx'

node.set['nginx']['port'] = 80
node.set['nginx']['default_root'] = node['pcp']['vector']['nginx_path']

template "#{node['nginx']['dir']}/sites-available/vector" do
  source node['pcp']['nginx']['template']
  cookbook node['pcp']['nginx']['template_cookbook']
  notifies :reload, 'service[nginx]' if ::File.exist?(::File.join(node['nginx']['dir'], 'sites-enabled', 'vector'))
end

nginx_site 'vector'

# create pcp repo from coremedia rpms
cache_dir = File.join(Chef::Config[:file_cache_path], node['pcp']['vector']['version'])
cache_tgz = File.join(cache_dir, node['pcp']['vector']['tgz'])
remote_tgz = "#{node['pcp']['vector']['url']}/#{node['pcp']['vector']['version']}/#{node['pcp']['vector']['tgz']}"

[cache_dir, node['pcp']['vector']['nginx_path']].each do |dir|
  directory dir do
    recursive true
  end
end

remote_file cache_tgz do
  checksum node['pcp']['vector']['checksum']
  source remote_tgz
  backup false
  action :create
  notifies :run, 'execute[extract_vector]', :immediately
end

execute 'extract_vector' do
  command "tar xzf #{cache_tgz} -C #{node['pcp']['vector']['nginx_path']} --no-acls --no-same-owner --no-same-permissions --no-xattrs"
  action :nothing
  notifies :reload, 'service[nginx]', :delayed
end
