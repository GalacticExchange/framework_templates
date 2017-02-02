dexec "sudo -u hdfs hdfs namenode -format -force"

dexec "service hadoop-hdfs-namenode start"

dexec "hdfs dfsadmin -safemode leave"

dexec "hadoop fs -mkdir -p /user/hdfs"
dexec "sudo -u hdfs hadoop fs -mkdir -p /user/hdfs"
dexec "sudo -u hdfs hadoop fs -chown hdfs /user/hdfs"
dexec "sudo -u hdfs hadoop fs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate"
dexec "sudo -u hdfs hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging"
dexec "sudo -u hdfs hadoop fs -chmod -R 1777 /tmp"
dexec "sudo -u hdfs hadoop fs -mkdir -p /var/log/hadoop-yarn"
dexec "sudo -u hdfs hadoop fs -chown yarn:mapred /var/log/hadoop-yarn"
dexec "sudo -u hdfs hadoop fs -mkdir -p /user/root"

# init spark history server
dexec "sudo -u hdfs hadoop fs -mkdir /user/spark"
dexec "sudo -u hdfs hadoop fs -mkdir /user/spark/applicationHistory"
dexec "sudo -u hdfs hadoop fs -chown -R spark:spark /user/spark"
dexec "sudo -u hdfs hadoop fs -chmod 1777 /user/spark/applicationHistory"
dexec "sudo -u spark hadoop fs -mkdir -p /user/spark/share/lib"

dexec "sudo -u hdfs hadoop fs -mkdir -p /user/hive/warehouse"
dexec "sudo -u hdfs hadoop fs -chmod 1777 /user/hive/warehouse"
dexec "sudo -u hdfs hadoop fs -chown hive:hadoop /user/hive/warehouse"

# ENTERPRISE sudo -u hdfs hadoop fs -mkdir /user/oozie""
# ENTERPRISE sudo -u hdfs hadoop fs -chown oozie:oozie /user/oozie""

# ENTERPRISE  sudo -u hdfs hadoop fs -mkdir /user/oozie && \
# ENTERPRISE  sudo -u hdfs hadoop fs -chown oozie:oozie /user/oozie

dexec "sudo -u hdfs hadoop fs -mkdir /solr"
dexec "sudo -u hdfs hadoop fs -chown solr /solr"

dexec "sudo usermod -G hadoop hive"

dexec "rm /etc/cassandra/cassandra-topology.properties"

dexec "cp /etc/hadoop/conf/core-site.xml /etc/impala/conf/core-site.xml"

dexec "cp etc/hadoop/conf/hdfs-site.xml /etc/impala/conf/hdfs-site.xml"

dexec "cp /etc/hive/conf/hive-site.xml /etc/impala/conf/hive-site.xml"