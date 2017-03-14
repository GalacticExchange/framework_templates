package io.gex.data_enchilada;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesReader {
    private final static Logger logger = LogManager.getLogger(PropertiesReader.class);
    final static String PROPERTIES_FILENAME = "/etc/data_enchilada/data_enchilada.properties";

    public final static String HIVE_METASTORE_URIS = "hive_metastore_uris";
    public final static String HDFS_URL = "hdfs_url";
    public final static String KAFKA = "kafka";
    public final static String ZOOKEEPER = "zookeeper";
    public final static String SCHEMAREGISTRY = "schemaregistry";
    public final static String TOPICS_DIR = "topics_dir";
    public final static String ELASTICSEARCH_URL = "elasticsearch_url";
    public final static String ELASTICSEARCH_INDEX = "elasticsearch_index";
    public final static String CASSANDRA_HOST = "cassandra_host";
    public final static String CASSANDRA_PORT = "cassandra_port";
    public final static String CASSANDRA_USERNAME = "cassandra_username";
    public final static String CASSANDRA_PASSWORD = "cassandra_password";
    public final static String CASSANDRA_KEYSPACE = "cassandra_keyspace";
    public final static String TIME_FIELD = "time_field";

    static Properties read() throws Exception {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        File file = new File(PROPERTIES_FILENAME);
        if (!file.exists() || file.length() == 0) {
            throw new Exception("File empty or not present.");
        }
        Properties properties = new Properties();
        try (InputStream input = new FileInputStream(file)) {
            properties.load(input);
        }
        for (String key : properties.stringPropertyNames()) {
            logger.info(key + " => " + properties.getProperty(key));
        }
        return properties;
    }
}
