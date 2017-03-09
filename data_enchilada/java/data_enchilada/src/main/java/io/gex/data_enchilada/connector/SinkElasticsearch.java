package io.gex.data_enchilada.connector;

import io.gex.data_enchilada.DataEnchilada;
import io.gex.data_enchilada.DataEnchiladaHelper;
import io.gex.data_enchilada.PropertiesReader;
import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

public class SinkElasticsearch implements Sink {

    private final static Logger logger = LogManager.getLogger(SinkElasticsearch.class);

    private final static String ELASTICSEARCH_TEMPLATE_FILENAME = Sink.TEMPLATE_PATH + "template-elasticsearch.properties";

    private String propertiesFilePath;
    private String topic;
    private String name;
    private String url;
    private String index;

    // name filed is needed for multiple sinks of the one type
    SinkElasticsearch(String topic, String name) throws Exception {
        this.topic = topic;
        this.name = name + "-elasticsearch-sink";
        this.propertiesFilePath = Paths.get(DataEnchilada.configDir, name + "-elasticsearch.properties").toString();
        this.url = DataEnchilada.properties.getProperty(PropertiesReader.ELASTICSEARCH_URL);
        this.index = DataEnchilada.properties.getProperty(PropertiesReader.ELASTICSEARCH_INDEX);
        checkConfig();
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
}
