



Chef::Log.info("Creating #{node["apache"]["installation"]["dir"]}/state sub directory to house the state for the environment")
directory "#{node["apache"]["installation"]["dir"]}/state" do
  owner "root"
  group "root"
  mode 0755
  action :create
  not_if do FileTest.directory?('#{node["apache"]["installation"]["dir"]}/state') end
end