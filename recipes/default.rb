=begin
#<
This recipe installs coremedia pcp repo and default pcp packages.
#>
=end

yum_repository 'pcp' do
  description 'PCP Packages Linux 6 - $basearch'
  baseurl "#{node['pcp']['yum']['baseurl']}"
  repositoryid 'pcp'
  enabled true
  gpgcheck false
  sslverify false
  sslcacert '/etc/pki/tls/certs/ca-bundle.crt'
  action :create
  make_cache true
end

%w(pcp pcp-conf pcp-libs pcp-webapi).each do |p|
  package p
end