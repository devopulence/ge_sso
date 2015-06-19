



yum_package "glibc" do
  arch "i686"
  action :install
end

yum_package "compat-libstdc++-33" do
  arch "x86_64"
  action :install
end

service "apache2" do
  case node['platform_family']
    when "rhel", "fedora", "suse"
      service_name "httpd"
      start_command "/sbin/service httpd start && sleep 1"
      stop_command "/sbin/service httpd stop && sleep 1"
      restart_command "/sbin/service httpd restart && sleep 1"
      reload_command "/sbin/service httpd reload && sleep 1"
    when "debian"
      service_name "apache2"
      restart_command "/usr/sbin/invoke-rc.d apache2 restart && sleep 1"
      reload_command "/usr/sbin/invoke-rc.d apache2 reload && sleep 1"
    when "arch"
      service_name "httpd"
    when "freebsd"
      service_name "apache22"
  end
  supports [:restart, :reload, :status, :start, :stop]
  action :enable
end