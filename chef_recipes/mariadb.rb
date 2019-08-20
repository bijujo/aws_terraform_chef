#
# Cookbook:: wordpress
# Recipe:: mariadb
#
# Copyright:: 2019, The Authors, All Rights Reserved.
package %w(mariadb-server mariadb) do
  action :install
end
service "mariadb" do
  action [:enable, :start]
end
# Set root password
execute 'set_root_pw' do
  command '/usr/bin/mysqladmin -u root password root123'
end

# Create wordpress DB
execute 'create_wordpress_db' do
  command '/usr/bin/mysqladmin -u root -proot123 create wordpress'
end
