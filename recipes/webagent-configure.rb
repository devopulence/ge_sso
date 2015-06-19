#
# Cookbook Name:: ge_EAS
# Recipe:: webagent-configure
#

#search(:ge_EAS_support, "*:*") do |cuenta|

#  default['webagent']['admin']['user'] = cuenta['id']
#  default['webagent']['admin']['password'] = cuenta['password']

#  template "#{node['temp_folder']}/nete-wa-installer.properties-bck}" do
#  source "nete-wa-installer.properties-bck.erb"
#    mode 00777
#    owner "root"
#    group "root"
#  end
#end

#COncatenate both nete-wa-installer.properties together
#bash "concatenate nete-wa-installer.properties" do
 # user "root"
  #cwd "#{node['temp_folder']}"
 # code <<-EOH
 # cat "#{node['temp_folder']}/nete-wa-installer.properties-bck} >> #{node['temp_folder']}/nete-wa-installer.properties}"
 # EOH
#end

file "#{node['temp_folder']}/nete-wa-installer.properties" do
  action :delete
  only_if do File.exists?("#{node['temp_folder']}/nete-wa-installer.properties") end
end

template "#{node['webagent']['install_dir']}/install_config_info/nete-wa-installer.properties" do
  source "nete-wa-installer.properties.good.erb"
  mode 00777
  owner "root"
  group "root"
end

# Modify permissions on newly created configuration binary.
execute "permissions" do
  command "chmod 777 #{node['webagent']['install_dir']}/install_config_info/nete-wa-config.bin"
end

directory "#{node['apache']['log']['dir']}/smlog" do
  owner "root"
  group "root"
  mode 0777
  action :create
end
  
# Unattended configuration using WebAgent properties file
#bash "configure_webagent" do
#  user "root"
# cwd "#{node['webagent']['install_dir']}/install_config_info"
#  code <<-EOH
#  ./nete-wa-config.bin -f #{node['temp_folder']}/nete-wa-installer.properties -i silent
# EOH
#end


#execute "nete-wa-config" do
#  cwd "#{node['webagent']['install_dir']}/install_config_info"
#  command "./nete-wa-config.bin -f #{node['temp_folder']}/nete-wa-installer.properties -i silent"
#  action :run
#end



# Unattended configuration using WebAgent properties file
#bash "configure_webagent" do
# user "root"
#cwd "#{node['webagent']['install_dir']}/install_config_info"
#  code <<-EOH
#  ./nete-wa-config.bin -f nete-wa-installer.properties -i silent
# EOH
#end

#Good Config  ########################
execute "nete-wa-config" do
  cwd "#{node['webagent']['install_dir']}/install_config_info"
  command "./nete-wa-config.bin -f nete-wa-installer.properties -i silent"
  action :run
end
############################
## Creates configuration files for the WebAgent
template "#{node['apache']['installation']['dir']}/conf/WebAgent.conf" do
  source "WebAgent.conf.erb"
  mode 0775
  owner "root"
  group "root"
end

template "#{node['apache']['installation']['dir']}/conf/LocalConfig.conf" do
  source "LocalConfig.conf.erb"
  helpers(EAS::Helpers)
  mode 0775
  owner "root"
  group "root"
end

# Copy WebAgent installation binary
cookbook_file "/var/www/html/comprep/login.fcc" do
  source "login.fcc"
  mode 00777
end

template "#{node['apache']['installation']['dir']}/conf/LocalConfig.conf" do
  source "LocalConfig.conf.erb"
  mode 0775
  owner "root"
  group "root"
end

#Copy httpd.conf for WebAgent
#template "#{node['apache']['installation']['dir']}/conf/httpd.conf" do
#  source "httpd.conf.erb"
#  mode 0775
#  owner "root"
#  group "root"
#end


# Restart Apache
#bash "start_apache" do
#  user "root"
#  code <<-EOH
#  export LD_LIBRARY_PATH="#{node['webagent']['install_dir']}/bin"
#  export PATH="#{node['webagent']['bin_dir']}":${PATH}
#  cd #{node['apache']['installation']['dir']}/bin/
#  ./httpd -k start
#  EOH
#end

execute "chcon webagent.log" do
  command "chcon -t httpd_sys_content_rw_t /etc/netegrity/siteminder6qmr5/webagent/log/"
  action :run
end


service "apache2" do
  action :stop
  #  only_if do  File.exists?("/etc/httpd/conf/httpd.conf") end

end

service "apache2" do
  action :start
  #  only_if do  File.exists?("/etc/httpd/conf/httpd.conf") end

end

#execute "chcon webagent.log" do
#  command "chcon -t httpd_sys_content_rw_t /etc/netegrity/siteminder6qmr5/webagent/log/webagent.log"
#  action :run
#  notifies :stop, "service[apache2]", :immediately
#  notifies :start, "service[apache2]", :immediately
#end

#service "apache2" do
#  action :stop
#  #  only_if do  File.exists?("/etc/httpd/conf/httpd.conf") end
#
#end

#service "apache2" do
#  action :start
#  #  only_if do  File.exists?("/etc/httpd/conf/httpd.conf") end
#
#end

