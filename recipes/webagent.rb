
ruby_block "set-env-java-home" do
  block do
    ENV["JAVA_HOME"] = '/usr/bin/java'
  end
end
#cookbook_file "/tmp/nete-wa-6qmr5-cr035-rhas30-x86-64.bin" do
#  source "nete-wa-6qmr5-cr035-rhas30-x86-64.bin"
#  action :delete
#  not_if do FileTest.directory?("/tmp/nete-wa-6qmr5-cr035-rhas30-x86-64.bin") end
#end

cookbook_file "/tmp/nete-wa-6qmr5-cr035-rhas30-x86-64.bin" do
  source "nete-wa-6qmr5-cr035-rhas30-x86-64.bin"
  mode 00777
  not_if do ::File.exists?('/tmp/nete-wa-6qmr5-cr035-rhas30-x86-64.bin') end
end

# Copy WebAgent properties file for unattended installations
template "#{node['temp_folder']}/nete-wa-installer.properties" do
  source "nete-wa-installer.properties.erb"
  mode 00777
  owner "root"
  group "root"

end


bash "install_webagent" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  ./nete-wa-6qmr5-cr035-rhas30-x86-64.bin -i silent -f /tmp/nete-wa-installer.properties
  EOH
  not_if do ::File.exists?('/etc/netegrity/siteminder6qmr5/webagent/license.txt') end
end


