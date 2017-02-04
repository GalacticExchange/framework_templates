dexecs(
    "service zookeeper-server init --force",
    "service hadoop-hdfs-namenode start",

    "hdfs dfsadmin -safemode leave",

    "hadoop fs -mkdir -p /user/hdfs",
    "sudo -u hdfs hadoop fs -mkdir -p /user/hdfs",
    "sudo -u hdfs hadoop fs -chown hdfs /user/hdfs",
    "sudo -u hdfs hadoop fs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate",
    "sudo -u hdfs hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging",
    "sudo -u hdfs hadoop fs -chmod -R 1777 /tmp",
    "sudo -u hdfs hadoop fs -mkdir -p /var/log/hadoop-yarn",
    "sudo -u hdfs hadoop fs -chown yarn:mapred /var/log/hadoop-yarn",
    "sudo -u hdfs hadoop fs -mkdir -p /user/root",

    # init spark history server

    "sudo -u hdfs hadoop fs -mkdir /user/spark",
    "sudo -u hdfs hadoop fs -mkdir /user/spark/applicationHistory",
    "sudo -u hdfs hadoop fs -chown -R spark:spark /user/spark",
    "sudo -u hdfs hadoop fs -chmod 1777 /user/spark/applicationHistory",
    "sudo -u spark hadoop fs -mkdir -p /user/spark/share/lib",

    "sudo -u hdfs hadoop fs -mkdir -p /user/hive/warehouse",
    "sudo -u hdfs hadoop fs -chmod 1777 /user/hive/warehouse",
    "sudo -u hdfs hadoop fs -chown hive:hadoop /user/hive/warehouse",

    # ENTERPRISE sudo -u hdfs hadoop fs -mkdir /user/oozie""
    # ENTERPRISE sudo -u hdfs hadoop fs -chown oozie:oozie /user/oozie""

    # ENTERPRISE  sudo -u hdfs hadoop fs -mkdir /user/oozie && \
    # ENTERPRISE  sudo -u hdfs hadoop fs -chown oozie:oozie /user/oozie

    "sudo -u hdfs hadoop fs -mkdir /solr",
    "sudo -u hdfs hadoop fs -chown solr /solr",

    "sudo usermod -G hadoop hive",

    "rm /etc/cassandra/cassandra-topology.properties",

    "cp /etc/hadoop/conf/core-site.xml /etc/impala/conf/core-site.xml",

    "cp etc/hadoop/conf/hdfs-site.xml /etc/impala/conf/hdfs-site.xml",

    "cp /etc/hive/conf/hive-site.xml /etc/impala/conf/hive-site.xml",

    "update-alternatives --set sqoop2-tomcat-conf /etc/sqoop2/tomcat-conf.dist",

    "ln -s /usr/share/java/mysql-connector-java.jar /usr/lib/hive/lib/libmysql-java.jar",

    "cp /usr/lib/hadoop/etc/hadoop/*.xml /usr/lib/hadoopinput"

#COPY download/log4j.properties /etc/hadoop/conf/log4j.properties
)

