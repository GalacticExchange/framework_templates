dexecs(


    "cat /tmp/hadoop_rsa_public >>  /root/.ssh/authorized_keys",
    "cp -f /tmp/hadoop_rsa /root/.ssh/",
    "chmod 600 /root/.ssh/hadoop_rsa",
    "chmod 600 /root/.ssh/authorized_keys",
    "sudo -u hdfs hdfs namenode -format -force",
    "service hadoop-hdfs-namenode start",
    "service zookeeper-server init --force",
    "sudo usermod -G hadoop hive",
    "cp -f /etc/hadoop/conf/core-site.xml /etc/impala/conf/core-site.xml",
    "cp -f /etc/hadoop/conf/hdfs-site.xml /etc/impala/conf/hdfs-site.xml",
    "cp -f /etc/hive/conf/hive-site.xml /etc/impala/conf/hive-site.xml",
    "update-alternatives --set sqoop2-tomcat-conf /etc/sqoop2/tomcat-conf.dist",

    "hdfs dfsadmin -safemode leave | true",
    "hadoop fs -mkdir -p /user/hdfs",
    "sudo -u hdfs hadoop fs -mkdir -p /user/hdfs " +
    "/tmp/hadoop-yarn/staging/history/done_intermediate " +
    "/var/log/hadoop-yarn  /user/root  /user/spark /solr " +
    "/user/spark/applicationHistory /user/spark/share/lib  /user/hive/warehouse" ,
    "sudo -u hdfs hadoop fs -chown hdfs /user/hdfs",
    "sudo -u hdfs hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging",
    "sudo -u hdfs hadoop fs -chmod -R 1777 /tmp",
    "sudo -u hdfs hadoop fs -chown yarn:mapred /var/log/hadoop-yarn",

    # init spark history server

    "sudo -u hdfs hadoop fs -chown -R spark:spark /user/spark",
    "sudo -u hdfs hadoop fs -chmod 1777 /user/spark/applicationHistory",
    "sudo -u hdfs hadoop fs -chmod 1777 /user/hive/warehouse",
    "sudo -u hdfs hadoop fs -chown hive:hadoop /user/hive/warehouse",

    # ENTERPRISE sudo -u hdfs hadoop fs -mkdir /user/oozie""
    # ENTERPRISE sudo -u hdfs hadoop fs -chown oozie:oozie /user/oozie""

    # ENTERPRISE  sudo -u hdfs hadoop fs -mkdir /user/oozie && \
    # ENTERPRISE  sudo -u hdfs hadoop fs -chown oozie:oozie /user/oozie

    "sudo -u hdfs hadoop fs -chown solr /solr",


#COPY download/log4j.properties /etc/hadoop/conf/log4j.properties
)

