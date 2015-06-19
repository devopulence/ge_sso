#
# Cookbook Name:: ge_EAS
# Recipe:: webagent-post-install
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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

execute "chcon for html dir" do
  command "chcon -t httpd_sys_content_rw_t /etc/netegrity/siteminder6qmr5/webagent/log/webagent.log"
  action :run
end

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

