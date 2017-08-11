dexec "/bin/bash -c 'echo \"export TERM=xterm\" >> /etc/bash.bashrc'"
dexec "/bin/bash -c \"echo $'\nexport PYTHONPATH=/home/superset/.superset:$PYTHONPATH' >> /etc/profile\""
dexec "/bin/bash -c \"echo $'\nexport PYTHONPATH=/home/superset/.superset:$PYTHONPATH' >> /etc/environment\""
# source /etc/profile

dexec "cp /etc/hadoop/conf/core-site.xml /etc/impala/conf/core-site.xml"

dexec "cp etc/hadoop/conf/hdfs-site.xml /etc/impala/conf/hdfs-site.xml"

dexec "cp /etc/hive/conf/hive-site.xml /etc/impala/conf/hive-site.xml"

if get_value('_components').include?('nifi')
  dexec "/bin/bash -c 'chmod 777 /usr/local/nifi/bin/nifi-env.sh'"
end

if get_value('_components').include?('superset')
  dexec "/home/superset/.bin/superset-init"
end

dexec 'echo 100000 > /proc/sys/kernel/threads-max'

dexec "echo '*         hard    nofile      500000' >> /etc/security/limits.conf"
dexec "echo '*         soft    nofile      500000' >> /etc/security/limits.conf"
dexec "echo 'root      hard    nofile      500000' >> /etc/security/limits.conf"
dexec "echo 'root      soft    nofile      500000' >> /etc/security/limits.conf"
dexec "echo '*         soft    nproc       500000' >> /etc/security/limits.conf"
dexec "echo '*         hard    nproc       500000' >> /etc/security/limits.conf"