# Description

This is an application cookbook. It provides recipes to install:

* pcp packages (performance co-pilot)

* vector frontend running in nginx virtual host 

## Prerequisites

* YUM Repository with pcp packages
* `Since Vector depends on version 3.10 or higher, the packages currently available on most Linux distro repositories would not suffice. Until newer versions are available in the repositories, you should be able to install PCP from binary packages made available by the NetflixOSS project on Bintray or build it from source.`

### Quick notes for building on CentOs 6

#### needed build time packages
```Shell
yum install git gcc bison flex gcc-c++ qt-devel
yum install perl-ExtUtils-MakeMaker
yum install ncurses-devel readline-devel
```

#### with-webapi
- needed for vector
```Shell
yum install libmicrohttpd-devel
```

#### needed runtime packages
```Shell
yum install perl-JSON perl-Time-HiRes
```

#### building rpms 
```Shell
git clone https://git.pcp.io/pcp
cd pcp
```
* modify Makepkgs to enable --with-webapi in build options
```Shell
./Makepkgs 
```

* packages can be found in rpm folder
./pcp-3.10.5/build/rpm/ 

#### install for vector
```Shell
yum install pcp pcp-libs pcp-webapi pcp-conf
```


## Platform:

* Redhat (~> 6.0)
* Centos (~> 6.0)

## Cookbooks:

* yum
* nginx
* chef-vault

# Attributes

* `node['pcp']['vector']['url']` - Defaults to `https://bintray.com/artifact/download/netflixoss/downloads`
* `node['pcp']['vector']['tgz']` - Defaults to `vector.tar.gz`
* `node['pcp']['vector']['version']` - Defaults to `1.0.1`
* `node['pcp']['vector']['checksum']` - Defaults to `f4b0e74409ec0fbb60ce30210ff4e39d4c42cd2b190c4ad3340f24d6d9208c0e`
* `node['pcp']['vector']['nginx_path']` - Defaults to `/var/www/html/vector`
* `node['pcp']['nginx']['template']` - Defaults to `vector-site.erb`
* `node['pcp']['nginx']['template_cookbook']` - Defaults to `pcp`
* `node['pcp']['nginx']['fqdn']` - Defaults to `vector.coremedia.com`
* `node['pcp']['yum']['baseurl']` - Default to `http://mirror.coremedia.vm/pcp/el/6/$basearch`

# Recipes

* [pcp::default] - The recipe installs pcp yum repo and pcp packages needed to work with vector. (pcp pcp-conf pcp-libs pcp-webapi)
* [pcp::vector] - The recipe installs nginx and enables a site for vector

# Data Bags / Vault


# Author

Author: Daniel Zabel (<daniel.zabel@coremedia.com>)
