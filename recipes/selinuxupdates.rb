

execute "chcon texrel" do
  command "chcon -v -t texrel_shlib_t #{node['webagent']['bin_dir']}/*.so"
  action :run
end

execute "setsebool" do
  command "setsebool -P httpd_execmem 1"
  action :run
end

# LLAWP
execute "chcon httpd" do
  command "chcon --reference=/usr/sbin/httpd #{node['webagent']['bin_dir']}/LLAWP"
  action :run
end


#execute "chcon for html dir" do
#  command "chcon --reference=/etc/httpd/logs/error_log /etc/httpd/logs/smlog/"
#  action :run
#end


execute "chcon for html dir" do
  command "chcon --reference=/etc/httpd/logs/error_log /etc/netegrity/siteminder6qmr5/webagent/log/"
  action :run
end



#chcon -t httpd_sys_content_rw_t

#Temporarily disable selinux
#execute "temporarily disable selinux" do
#  command "echo 0 >/selinux/enforce"
#  action :run
#end
