dexec "/bin/bash -c 'echo \"export TERM=xterm\" >> /etc/bash.bashrc'"

dexec "cp /etc/hadoop/conf/core-site.xml /etc/impala/conf/core-site.xml"

dexec "cp etc/hadoop/conf/hdfs-site.xml /etc/impala/conf/hdfs-site.xml"

dexec "cp /etc/hive/conf/hive-site.xml /etc/impala/conf/hive-site.xml"

# nifi
dexec "/bin/bash -c 'chmod 777 /usr/local/nifi/bin/nifi-env.sh'"

# superset
dexec "/home/superset/.bin/superset-init"

# neo4j
dexec "/bin/bash -c 'curl -H \"Content-Type: application/json\" -X POST -d \"{\"password\":\"password\"}\" -u neo4j:neo4j http://localhost:7474/user/neo4j/password'"
dexec "/bin/bash -c 'curl -H \"Content-Type: application/json\" -X POST -d \"{\"password\":\"neo4j\"}\" -u neo4j:password http://localhost:7474/user/neo4j/password'"