dexecs_parallel(
    "bash -c 'cat /tmp/hadoop_rsa_public >>  /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys'",
    "bash -c 'cp -f /tmp/hadoop_rsa /root/.ssh/ && chmod 600 /root/.ssh/hadoop_rsa'",
    "service zookeeper-server init --force",
    "cp -f /etc/hadoop/conf/core-site.xml /etc/impala/conf/core-site.xml",
    "cp -f /etc/hadoop/conf/hdfs-site.xml /etc/impala/conf/hdfs-site.xml",
    "cp -f /etc/hive/conf/hive-site.xml /etc/impala/conf/hive-site.xml",
    "update-alternatives --set sqoop2-tomcat-conf /etc/sqoop2/tomcat-conf.dist",
)
dexec "service hadoop-hdfs-namenode start"


#dexec "hdfs dfsadmin -safemode leave | true"



#COPY download/log4j.properties /etc/hadoop/conf/log4j.properties


