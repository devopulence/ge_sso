#
# Cookbook Name:: ge_sso
# Recipe:: test_ge_sso
#
# Copyright 2013, GE Capital
#
# All rights reserved - Do Not Redistribute
#
# Use this recipe to excercise parts of the cookbook that you dont want to put in default.rb
# This is particularly useful to excercise LWRP's


include_recipe 'ge_apache::default'

ge_apache_baseconfig "comprep" do
  app_name        "comprep"
  server_name     "comprep-union.frictionless.capital.ge.com"
  vhost_type      "proxy"
  listen_to_http  true
  listen_to_https true

end








include_recipe 'ge_sso::default'