package io.gex.data_enchilada.connector;

import io.gex.data_enchilada.*;
import org.apache.avro.Schema;
import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;

import java.io.File;
import java.net.InetAddress;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

public class SinkElasticsearch implements Sink {

    private final static Logger logger = LogManager.getLogger(SinkElasticsearch.class);

    private final static String ELASTICSEARCH_TEMPLATE_FILENAME = Sink.TEMPLATE_PATH + "template-elasticsearch.properties";

    private String propertiesFilePath;
    private String topic;
    private String name;
    private String url;
    private String index;
    private String host;
    private String timeFiled;
    private String clusterName;

    // name filed is needed for multiple sinks of the one type
    SinkElasticsearch(String topic, String name) throws Exception {
        this.topic = topic;
        this.index = topic.substring(0, topic.lastIndexOf("_"));
        this.name = name + "-elasticsearch-sink";
        this.propertiesFilePath = Paths.get(DataEnchilada.configDir, name + "-elasticsearch.properties").toString();
        this.url = DataEnchilada.properties.getProperty(PropertiesReader.ELASTICSEARCH_URL);
        this.clusterName = DataEnchilada.properties.getProperty(PropertiesReader.ELASTICSEARCH_CLUSTER_NAME);
        this.host = this.url.replaceAll("http://", "").replaceAll("https://", "").split(":")[0];

        this.timeFiled = DataEnchilada.properties.getProperty(PropertiesReader.TIME_FIELD);
        checkConfig();
        checkSchema();
    }

    @Override
    public void checkConfig() throws Exception {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        File file = new File(propertiesFilePath);
        if (!file.exists()) {
            FileUtils.copyFile(new File(ELASTICSEARCH_TEMPLATE_FILENAME), file);
            String content = new String(Files.readAllBytes(file.toPath()), StandardCharsets.UTF_8);
            content = content.replaceAll("\\{insert_name}", name).replaceAll("\\{insert_topics}", topic).
                    replaceAll("\\{insert_connection.url}", url).replaceAll("\\{insert_index}", index);
            Files.write(file.toPath(), content.getBytes(StandardCharsets.UTF_8));
        }
    }

    @Override
    public String getPropertiesFilePath() {
        return propertiesFilePath;
    }

    private void checkSchema() throws Exception {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        TransportClient client = null;
        try {
            Settings settings = Settings.builder().put("cluster.name", clusterName).build();
            client = TransportClient.builder().settings(settings).build().addTransportAddress(new InetSocketTransportAddress(InetAddress.getByName(host), 9300));
            if (!client.admin().indices().prepareExists(index).execute().actionGet().isExists()) {
                client.admin().indices().prepareCreate(index).get();
            }
            if (!client.admin().indices().prepareTypesExists(index).setTypes(topic).execute().actionGet().isExists()) {
                client.admin().indices().preparePutMapping(index).setType(topic).setSource(generateSource()).get();
            }
        } catch (Throwable e) {
            logger.error(e.getMessage(), e);
            throw e;
        } finally {
            if (client != null) {
                client.close();
            }
        }

    }

    private String generateSource() throws Exception {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        StringBuilder stringBuilder = new StringBuilder("{\n  \"properties\": {\n");
        Schema schema = SchemaRegistry.getSchema(topic + "-value");
        List<Schema.Field> fields = schema.getFields();
        for (Schema.Field field : fields) {
            stringBuilder.append("    \"").append(field.name()).append("\": {\n").append(getType(field)).append("\n    },\n");
        }
        stringBuilder.delete(stringBuilder.length() - 2, stringBuilder.length()).append("\n  }\n}");
        logger.info(stringBuilder.toString());
        return stringBuilder.toString();

    }

    private String getType(Schema.Field field) {
        StringBuilder stringBuilder = new StringBuilder("      \"type\": ");
        if (field.name().equals(timeFiled)) {
            stringBuilder.append("\"date\"");
        } else {
            String value = null;
            Schema.Type type = field.schema().getType();
            if (type != Schema.Type.UNION) {
                value = AvroToElasticsearchDataType.getValue(field.schema().getType());
            } else {
                for (Schema s : field.schema().getTypes()) {
                    //work only for 2 parameters with null
                    if (s.getType() != Schema.Type.NULL) {
                        value = AvroToElasticsearchDataType.getValue(s.getType());
                    }
                }
            }
            stringBuilder.append("\"").append(value).append("\"");
            if (AvroToElasticsearchDataType.STRING.get().equals(value)) {
                stringBuilder.append(",\n      \"analyzer\": \"standard\"");
            }
        }
        return stringBuilder.toString();
    }
}
