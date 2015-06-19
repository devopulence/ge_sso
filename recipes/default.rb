#
# Cookbook Name:: ge_sso
# Recipe:: default
#
# Copyright 2013, GE Capital
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'ge_iptables'



  # we need to update yum before being able to install softwares we need
  #execute "yum-update" do
  # ignore_failure true
  #  epic_fail true
  #  command "yum update -y"
  #  action :run
  #end

if File.exist?('/etc/httpd/LocalConfig.conf')
  # need to send value to nete-wa-installer.properties.good.erb in webagent-configure.rb
   puts 'file exists - its a hit - retrieve value from file'
else
  puts  'file does not exist'
end

# pass value to template

extend EAS::Helpers
 theTrustedHost =  getTrustedHostName
Chef::Log.info("Joette  #{theTrustedHost}")





Chef::Log.info("joette")

ip = '10.10.0.0/24'
themask = IPAddress.netmask(node) # here we use the library method
Chef::Log.info("Jaclyn of #{ip}: #{themask}")

log "message" do
  message "johndesp of #{ip}: #{themask}"
  level :info
end
if Dir.exists?("#{node['apache']['installation']['dir']}")

include_recipe "ge_sso::state"
include_recipe "ge_sso::setiptables"
include_recipe "ge_sso::packages"
#include_recipe "ge_sso::selinuxupdates"
include_recipe "ge_sso::webagent"

# the following needs to be run after the webagent is installed
include_recipe "ge_sso::selinuxupdates"
include_recipe "ge_sso::httpdinitd"
if node['webagent']['configure_agent']
include_recipe "ge_sso::webagent-configure"
end


#include_recipe "ge_sso::selinuxupdates"
end




