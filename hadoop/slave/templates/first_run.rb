dexec "/bin/bash -c 'echo \"export TERM=xterm\" >> /etc/bash.bashrc'"

dexec "cp /etc/hadoop/conf/core-site.xml /etc/impala/conf/core-site.xml"

dexec "cp etc/hadoop/conf/hdfs-site.xml /etc/impala/conf/hdfs-site.xml"

dexec "cp /etc/hive/conf/hive-site.xml /etc/impala/conf/hive-site.xml"

# superset
dexec "/home/superset/.bin/superset-init"

#neo4j

