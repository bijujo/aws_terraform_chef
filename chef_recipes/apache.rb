#
# Cookbook:: wordpress
# Recipe:: apache
#
# Copyright:: 2019, The Authors, All Rights Reserved.
package "httpd" do
  action :install
end
service "httpd" do
  action [:enable, :start]
end
