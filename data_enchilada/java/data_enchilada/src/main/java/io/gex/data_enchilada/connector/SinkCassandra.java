package io.gex.data_enchilada.connector;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.KeyspaceMetadata;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.TableMetadata;
import io.gex.data_enchilada.*;
import org.apache.avro.Schema;
import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SinkCassandra implements Sink {

    private final static Logger logger = LogManager.getLogger(SinkCassandra.class);
    private final static String CASSANDRA_TEMPLATE_FILENAME = Sink.TEMPLATE_PATH + "template-cassandra.properties";
    private static final String PRIMARY_KEY = "enchilada_timestamp";

    private String propertiesFilePath;
    private String topic;
    private String name;
    private String query;
    private String username;
    private String password;
    private String keyspace;
    private String table;
    private String host;
    private Integer port;

    private Cluster cluster;
    private Session session;

    // name filed is needed for multiple sinks of the one type
    SinkCassandra(String topic, String name) throws Exception {
        this.topic = topic;
        this.name = name + "-cassandra-sink";
        this.propertiesFilePath = Paths.get(DataEnchilada.configDir, name + "-cassandra.properties").toString();
        this.query = "INSERT INTO " + topic + " SELECT * FROM " + topic;
        this.username = DataEnchilada.properties.getProperty(PropertiesReader.CASSANDRA_USERNAME);
        this.password = DataEnchilada.properties.getProperty(PropertiesReader.CASSANDRA_PASSWORD);
        this.keyspace = DataEnchilada.properties.getProperty(PropertiesReader.CASSANDRA_KEYSPACE);
        this.table = validateTableName(topic);
        this.host = DataEnchilada.properties.getProperty(PropertiesReader.CASSANDRA_HOST);
        this.port = Integer.valueOf(DataEnchilada.properties.getProperty(PropertiesReader.CASSANDRA_PORT));
        checkConfig();
    }

    private String validateTableName(String tableName) throws Exception {
        String tmp = tableName;
        Pattern p = Pattern.compile("[0-9a-zA-Z$_]+");
        Matcher m = p.matcher(tmp);
        if (!m.matches()) {
            //try to make simple changes to the table name
            tmp = tmp.replaceAll("[-.]", "_");
            if (!m.matches()) {
                throw new Exception("Invalid table name: " + tableName + ".");
            }
        }
        return tmp;
    }

    @Override
    public void checkConfig() throws Exception {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        File file = new File(propertiesFilePath);
        if (!file.exists()) {
            FileUtils.copyFile(new File(CASSANDRA_TEMPLATE_FILENAME), file);
            String content = new String(Files.readAllBytes(file.toPath()), StandardCharsets.UTF_8);
            content = content.replaceAll("\\{insert_name}", name).replaceAll("\\{insert_topics}", topic).
                    replaceAll("\\{insert_cassandra.host}", host).replaceAll("\\{insert_cassandra.port}", String.valueOf(port)).
                    replaceAll("\\{insert_cassandra.username}", username).replaceAll("\\{insert_cassandra.password}", password).
                    replaceAll("\\{insert_cassandra.query}", query).replaceAll("\\{insert_cassandra.key.space}", keyspace);
            Files.write(file.toPath(), content.getBytes(StandardCharsets.UTF_8));
        }
        try {
            checkConnection();
            buildCluster();
            checkKeyspace();
            connect();
            checkTable();
        } finally {
            close();
        }
    }

    private void checkConnection() throws Exception {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        try (Socket socket = new Socket()) {
            socket.connect(new InetSocketAddress(host, port), 3000);
        } catch (Throwable e) {
            logger.error("Failed to connect to Cassandra.");
            throw e;
        }
    }

    private void buildCluster() {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        cluster = Cluster.builder().addContactPoint(host).withPort(port).withCredentials(username, password).build();
    }

    private void checkKeyspace() {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        try {
            KeyspaceMetadata keyspaceMetadata = cluster.getMetadata().getKeyspace(keyspace);
            if (keyspaceMetadata != null) {
                return;
            }
            session = cluster.connect();
            session.execute("CREATE KEYSPACE " + keyspace + " WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor' : 1};");
        } catch (Throwable e) {
            logger.error(e.getMessage(), e);
            throw e;
        } finally {
            if (session != null) {
                try {
                    session.close();
                } catch (Throwable e) {
                    logger.warn(e.getMessage(), e);
                }
            }
        }
    }

    private void connect() {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        session = cluster.connect(keyspace);
    }

    private void checkTable() throws Exception {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        try {
            KeyspaceMetadata keyspaceMetadata = cluster.getMetadata().getKeyspace(keyspace);
            TableMetadata tableMetadata = keyspaceMetadata.getTable(table);
            if (tableMetadata != null) {
                return;
            }
        } catch (Throwable e) {
            logger.error(e.getMessage(), e);
            throw e;
        }
        String q = getQuery();
        logger.info(q);
        session.execute(q);
    }

    private String getQuery() throws Exception {
        return "CREATE TABLE " + table + " (" + getQueryParameters() + ");";
    }

    private String getQueryParameters() throws Exception {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        StringBuilder stringBuilder = new StringBuilder();
        Schema schema = SchemaRegistry.getSchema(topic + "-value");
        List<Schema.Field> fields = schema.getFields();
        for (Schema.Field field : fields) {
            Schema.Type type = field.schema().getType();
            if (type != Schema.Type.UNION) {
                stringBuilder.append(field.name()).append(" ").append(AvroToCassandraDataType.getValue(type)).append(",");
            } else {
                for (Schema s : field.schema().getTypes()) {
                    //work only for 2 parameters with null
                    if (s.getType() != Schema.Type.NULL) {
                        stringBuilder.append(field.name()).append(" ").append(AvroToCassandraDataType.getValue(s.getType())).append(",");
                    }
                }
            }
        }
        stringBuilder.append(" PRIMARY KEY (" + PRIMARY_KEY + ")");
        return stringBuilder.toString();
    }

    private void close() {
        // sessions will be closed automatically
        if (cluster != null && !cluster.isClosed()) {
            try {
                cluster.close();
            } catch (Throwable e) {
                logger.warn(e.getMessage(), e);
            }
        }
    }

    @Override
    public String getPropertiesFilePath() {
        return propertiesFilePath;
    }
}
