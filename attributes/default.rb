# Determine deploy type
default['webagent']['configure_agent']= false


# Global variables
default['environment'] = "stage"
default['shortcuts'] = "/usr"
default['temp_folder'] = "/tmp"





# Apache attributes
default['apache']['installation']['dir'] = "/etc/httpd"
default['apache']['log']['dir'] = "#{node['apache']['installation']['dir']}/logs"
default['apache']['version'] = "2.2.25"
default['apache']['config_object'] = "ApacheAgentConfigObject"
#default['apache']['agent_name'] = "archops_agent,stkag90512.softtekge.com:4567"
default['apache']['agent_name'] = "archops_agent_demo_site3,site3.archops.capital.ge.com"
# Webagent attributes
default['webagent']['install_dir'] = "/etc/netegrity/siteminder6qmr5/webagent"
default['webagent']['bin_dir'] = "#{node['webagent']['install_dir']}/bin"
default['webagent']['trusted_hostname'] = "johndesp.frictionless.capital.ge.com_trustedhost"
default['webagent']['config_object'] = "EAS_HCO"


# Siteminder stuff
default['siteminder']['host']['file'] = "SmHost.conf"
default['siteminder']['host']['dir'] = "#{node['webagent']['install_dir']}/config"
default['siteminder']['host']['register'] = "1"

# IPtables related attributes
case node['environment']
  when "stage"
    default['EAS']['policy'] = ["3.182.59.147"]
    default['EAS']['webservice'] = ["3.182.58.25"]
    default['EAS']['auth'] = ["3.182.59.147"]
  when "prod"
    default['EAS']['policy'] = ["3.182.59.141", "3.182.59.144"]
    default['EAS']['webservice'] = ["3.182.58.23"]
    default['EAS']['auth'] = ["3.182.59.141", "3.182.59.144"]
end


