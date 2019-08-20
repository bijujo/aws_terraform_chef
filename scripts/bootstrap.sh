#!/bin/bash -x
cd /root
/bin/yum install -y wget
/bin/wget https://packages.chef.io/files/stable/chefdk/4.1.7/el/7/chefdk-4.1.7-1.el7.x86_64.rpm
/bin/yum localinstall -y chefdk-4.1.7-1.el7.x86_64.rpm
/bin/mkdir /etc/chef/
/bin/printf "file_cache_path '/var/chef/cache'\ncookbook_path '/root'\n" > /etc/chef/solo.rb
/bin/printf "{ \"run_list\": [\"recipe[wordpress]\"]}\n" > /etc/chef/wordpress.json
/bin/printf "<\%= config_content \%>\nchef_license \"accept\"\n" > /etc/chef/client.rb
/bin/yum install -y git
/bin/git clone https://github.com/bijujo/wordpress.git chef
/bin/mkdir -p /root/wordpress/recipes/
\cp -rf /root/chef/* /root/wordpress/recipes/
/bin/chef-solo --chef-license accept-silent -c /etc/chef/solo.rb -j /etc/chef/wordpress.json
/sbin/service httpd restart
echo "Finished boot strap" > /root/boot.log
#EOF
