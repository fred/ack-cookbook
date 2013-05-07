execute "curl #{node['ack']['download']} > #{node['ack']['symlink_as']} && chmod 0755 #{node['ack']['symlink_as']}" do
  user "root"
  not_if "test -f #{node['ack']['symlink_as']}"
end


template "/etc/ackrc" do
  source "ackrc.erb"
  variables node[:ack]
  mode "0644"
end

file "/etc/profile.d/ack.sh" do
  content <<-EOF
#!/bin/sh
export ACKRC=/etc/ackrc
EOF
  mode "0644"
end