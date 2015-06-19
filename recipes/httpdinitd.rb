


# attempt to achieve idemptoence
#not_if {::File.exists?('/root/db_files/.finished')}
execute "cp /etc/init.d/httpd" do
  command "cp /etc/init.d/httpd /etc/init.d/httpd.bck"
  action :run
end

ruby_block "edit /etc/init.d/httpd" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/init.d/httpd")
    fe.insert_line_after_match(/^start/, ". #{node['webagent']['install_dir']}/nete_wa_env.sh\n")
    fe.write_file
  end

end


template "#{node["apache"]["installation"]["dir"]}/state/httpdstartup" do
  source "httpdstartup.erb"
  cookbook 'ge_sso'
  mode 0755
  owner "root"
  group "root"
  variables({
                :httpdstartup_complete => true


            })
  not_if do ::File.exists?('#{node["apache"]["installation"]["dir"]}/state/httpdstartup') end
end