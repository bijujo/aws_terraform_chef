#
# Cookbook:: wordpress
# Recipe:: wordpress
#
# Copyright:: 2019, The Authors, All Rights Reserved.
remote_file "/tmp/wordpress-5.1.1.tar.gz" do
   source "https://wordpress.org/wordpress-5.1.1.tar.gz"
   action :create_if_missing
end
execute 'wordpress_extract' do
  command 'tar -xzf /tmp/wordpress-5.1.1.tar.gz --directory /tmp'
end
execute 'wordpress_extract' do
  command 'cp -r /tmp/wordpress/* /var/www/html/'
end 
execute 'wordpress_extract' do
  command '/bin/mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php'
end
execute 'wordpress_extract' do
  command '/bin/sed -i "s/database_name_here/wordpress/g" /var/www/html/wp-config.php'
end
execute 'wordpress_extract' do
  command '/bin/sed -i "s/username_here/root/g" /var/www/html/wp-config.php'
end
execute 'wordpress_extract' do
  command '/bin/sed -i "s/password_here/root123/g" /var/www/html/wp-config.php'
end
