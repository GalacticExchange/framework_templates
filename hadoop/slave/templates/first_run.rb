dexec "/bin/bash -c 'echo \"export TERM=xterm\" >> /etc/bash.bashrc'"

dexec "cp /etc/hadoop/conf/core-site.xml /etc/impala/conf/core-site.xml"

dexec "cp etc/hadoop/conf/hdfs-site.xml /etc/impala/conf/hdfs-site.xml"

dexec "cp /etc/hive/conf/hive-site.xml /etc/impala/conf/hive-site.xml"

if get_value('_components').include?('nifi')
  # nifi
  dexec "/bin/bash -c 'chmod 777 /usr/local/nifi/bin/nifi-env.sh'"
end

if get_value('_components').include?('superset')
  # superset
  dexec "/home/superset/.bin/superset-init"
end

if get_value('_components').include?('neo4j')
  # neo4j
  dexec "/bin/bash -c 'chmod 777 /etc/neo4j/pass.sh'"
  dexec "/etc/neo4j/pass.sh'"
end