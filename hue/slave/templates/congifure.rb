hue_templates = '/etc/gex/templates'
hue_hosts_file = "#{INFO_DIR}/apps/hue/hosts"

echo_append "#{ENV['_hadoop_internal_ip']} hadoop-$(hostname)", hue_hosts_file
echo_append "#{ENV['_hue_internal_ip']} hue-$(hostname)", hue_hosts_file


dstart

dtemplate "/etc/gex/templates/auth/opt/gexauth/gexauth.rb.j2", "/tmp/#{ENV['_cluster_id']}_gexauth.rb"

dcp "/tmp/#{ENV['_cluster_id']}_gexauth.rb", "/opt/gexauth/gexauth.rb"

`/usr/sbin/avahi-daemon -r`
