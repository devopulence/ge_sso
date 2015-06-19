include_recipe "ge_iptables"

environ = node['environment']
puts("current environment =  #{environ}")






node['EAS']['policy'].each do |address|
  puts("instance id #{address}")

end

node['EAS']['policy'].each do |address|
  iptables_rule "EAS_policy_#{address}" do
    rule [
             "-A INPUT -p tcp -s #{address} --match multiport --dports 4441:4443 --jump ACCEPT",
             "-A OUTPUT -p tcp -d #{address} --match multiport --dports 4441:4443 --jump ACCEPT"
         ]
    weight 10
  end
end

node['EAS']['webservice'].each do |address|
  iptables_rule "EAS_webservice_#{address}" do
    rule [
             "-A INPUT -p tcp -s #{address} --dport 8443 --jump ACCEPT",
             "-A OUTPUT -p tcp -d #{address} --dport 8443 --jump ACCEPT"
         ]
    weight 10
  end
end
#Remove the following -
node['EAS']['auth'].each do |address|
  iptables_rule "EAS_auth_#{address}" do
    rule [
             "-A INPUT -p tcp -s #{address} --dport 3891 --jump ACCEPT",
             "-A OUTPUT -p tcp -d #{address} --dport 3891 --jump ACCEPT"
         ]
    weight 10
  end
end


iptables_rule "smtp" do
  rule [
           "-A INPUT -p tcp -m tcp --dport 25 -j ACCEPT",
       ]
  log  "-A INPUT -p tcp -m limit --limit 5/min -j LOG --log-prefix \"TCP_SMTP: \" --log-level 7"
  weight 1
end