# Cookbook:: wordpress
# Recipe:: default
# All these recipes together setup a working WordPress
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'wordpress::pre'
include_recipe 'wordpress::apache'
include_recipe 'wordpress::mariadb'
include_recipe 'wordpress::php'
include_recipe 'wordpress::wordpress'
