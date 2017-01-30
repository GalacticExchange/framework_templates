texec "sudo -u hdfs hdfs namenode -format"

texec "service hadoop-hdfs-namenode start"



texec "hdfs dfsadmin -safemode leave"

texec "hadoop fs -mkdir -p /user/hdfs"
texec "sudo -u hdfs hadoop fs -mkdir -p /user/hdfs"
texec "sudo -u hdfs hadoop fs -chown hdfs /user/hdfs"
texec "sudo -u hdfs hadoop fs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate"
texec "sudo -u hdfs hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging"
texec "sudo -u hdfs hadoop fs -chmod -R 1777 /tmp"
texec "sudo -u hdfs hadoop fs -mkdir -p /var/log/hadoop-yarn"
texec "sudo -u hdfs hadoop fs -chown yarn:mapred /var/log/hadoop-yarn"
texec "sudo -u hdfs hadoop fs -mkdir -p /user/root"

# init spark history server
texec "sudo -u hdfs hadoop fs -mkdir /user/spark"
texec "sudo -u hdfs hadoop fs -mkdir /user/spark/applicationHistory"
texec "sudo -u hdfs hadoop fs -chown -R spark:spark /user/spark"
texec "sudo -u hdfs hadoop fs -chmod 1777 /user/spark/applicationHistory"
texec "sudo -u spark hadoop fs -mkdir -p /user/spark/share/lib"

texec "sudo -u hdfs hadoop fs -mkdir -p /user/hive/warehouse"
texec "sudo -u hdfs hadoop fs -chmod 1777 /user/hive/warehouse"
texec "sudo -u hdfs hadoop fs -chown hive:hadoop /user/hive/warehouse"

# ENTERPRISE sudo -u hdfs hadoop fs -mkdir /user/oozie""
# ENTERPRISE sudo -u hdfs hadoop fs -chown oozie:oozie /user/oozie""

# ENTERPRISE  sudo -u hdfs hadoop fs -mkdir /user/oozie && \
# ENTERPRISE  sudo -u hdfs hadoop fs -chown oozie:oozie /user/oozie

texec "sudo -u hdfs hadoop fs -mkdir /solr"
texec "sudo -u hdfs hadoop fs -chown solr /solr"

texec "sudo usermod -G hadoop hive"