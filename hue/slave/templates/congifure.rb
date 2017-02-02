hue_templates = '/etc/gex/templates'
hue_hosts_file = "#{INFO_DIR}/apps/hue/hosts"

echo_append "#{ENV['_hadoop_internal_ip']} hadoop-$(hostname)", hue_hosts_file
echo_append "#{ENV['_hue_internal_ip']} hue-$(hostname)", hue_hosts_file


dstart


`/usr/sbin/avahi-daemon -r`
