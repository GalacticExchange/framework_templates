package io.gex.data_enchilada.connector;

import io.gex.data_enchilada.DataEnchilada;
import io.gex.data_enchilada.DataEnchiladaHelper;
import io.gex.data_enchilada.PropertiesReader;
import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.io.IOException;
import java.net.ServerSocket;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class Connector {

    private final static Logger logger = LogManager.getLogger(Connector.class);

    private final static int DEFAULT_PORT = 8083;
    private final static String SCHEMA_TEMPLATE_FILENAME = "/etc/data_enchilada/templates/template-schema.properties";
    public static int currentPort = DEFAULT_PORT;

    private String schemaPropertiesFilePath;
    private int restPort;
    private List<Sink> sinks = new ArrayList<>();
    private String topic;

    private Connector(String topic) throws Exception {
        this.schemaPropertiesFilePath = generateSchemaPropertiesFilePath(topic);
        this.restPort = selectPort();
        this.topic = topic;
        checkSchemaConfig();
    }

    public static String generateSchemaPropertiesFilePath(String topic) {
        return Paths.get(DataEnchilada.configDir, topic + "-connect-avro.properties").toString();
    }

    public String getTopic() {
        return topic;
    }

    public List<Sink> getSinks() {
        return sinks;
    }

    public String getSchemaPropertiesFilePath() {
        return schemaPropertiesFilePath;
    }

    public String getSinkPropertiesString() {
        StringBuilder builder = new StringBuilder(" ");
        for (Sink sink : sinks) {
            builder.append(sink.getPropertiesFilePath()).append(" ");
        }
        return builder.deleteCharAt(builder.length() - 1).toString();
    }

    private void checkSchemaConfig() throws Exception {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        File file = new File(schemaPropertiesFilePath);
        if (!file.exists()) {
            FileUtils.copyFile(new File(SCHEMA_TEMPLATE_FILENAME), file);
            String content = new String(Files.readAllBytes(file.toPath()), StandardCharsets.UTF_8);
            content = content.replaceAll("\\{insert_rest.port}", String.valueOf(restPort)).
                    replaceAll("\\{insert_kafka}", DataEnchilada.properties.getProperty(PropertiesReader.KAFKA)).
                    replaceAll("\\{insert_schemaregistry}", DataEnchilada.properties.getProperty(PropertiesReader.SCHEMAREGISTRY));
            Files.write(file.toPath(), content.getBytes(StandardCharsets.UTF_8));
        }
    }

    private static int selectPort() throws Exception {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        int port = currentPort;
        while (port != DEFAULT_PORT + 404) {
            try {
                ServerSocket serverSocket = new ServerSocket(port);
                serverSocket.close();
                currentPort = port + 1;
                return port;
            } catch (IOException ex) {
                port++;
            }
        }
        throw new Exception("Failed to select Kafka REST port.");
    }

    public static List<Connector> generate(List<String> topics) {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        List<Connector> connectors = new ArrayList<>();
        for (String topic : topics) {
            try {
                Connector connector = new Connector(topic);
                try {
                    connector.sinks.add(new SinkHDFS(topic, topic));
                } catch (Throwable e) {
                    logger.error("Failed to add HDFS sink to " + topic + " topic.", e);
                }
                try {
                    connector.sinks.add(new SinkElasticsearch(topic, topic));
                } catch (Throwable e) {
                    logger.error("Failed to add Elasticsearch sink to " + topic + " topic.", e);
                }
                try {
                    connector.sinks.add(new SinkCassandra(topic, topic));
                } catch (Throwable e) {
                    logger.error("Failed to add Cassandra sink to " + topic + " topic.", e);
                }
                connectors.add(connector);
            } catch (Throwable e) {
                logger.error(e.getMessage(), e);
                //continue
            }
        }
        return connectors;
    }
}
