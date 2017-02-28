package io.gex.enchilada.connector;

import io.gex.enchilada.Enchilada;
import io.gex.enchilada.EnchiladaHelper;
import io.gex.enchilada.PropertiesReader;
import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

public class SinkHDFS implements Sink {

    private final static Logger logger = LogManager.getLogger(SinkHDFS.class);
    private final static String HDFS_TEMPLATE_FILENAME = Sink.TEMPLATE_PATH + "/template-hdfs.properties";

    private String propertiesFilePath;
    private String topic;
    private String name;
    private String hdfsURL;
    private String hiveURL;
    private String topicsDir;

    // name filed is needed for multiple sinks of the one type
    SinkHDFS(String topic, String name) throws Exception {
        this.topic = topic;
        this.name = name + "-hdfs-sink";
        this.propertiesFilePath = Paths.get(Enchilada.configDir, name + "-hdfs.properties").toString();
        this.hdfsURL = Enchilada.properties.getProperty(PropertiesReader.HDFS_URL);
        this.hiveURL = Enchilada.properties.getProperty(PropertiesReader.HIVE_METASTORE_URIS);
        this.topicsDir = Enchilada.properties.getProperty(PropertiesReader.TOPICS_DIR);
        checkConfig();
    }

    @Override
    public void checkConfig() throws Exception {
        logger.trace("Entered " + EnchiladaHelper.getMethodName());
        File file = new File(propertiesFilePath);
        if (!file.exists()) {
            FileUtils.copyFile(new File(HDFS_TEMPLATE_FILENAME), file);
            String content = new String(Files.readAllBytes(file.toPath()), StandardCharsets.UTF_8);
            content = content.replaceAll("\\{insert_name}", name).replaceAll("\\{insert_topics}", topic).
                    replaceAll("\\{insert_hdfs.url}", hdfsURL).replaceAll("\\{insert_hive.metastore.uris}", hiveURL).
                    replaceAll("\\{insert_topics.dir}", topicsDir);
            Files.write(file.toPath(), content.getBytes(StandardCharsets.UTF_8));
        }
    }

    @Override
    public String getPropertiesFilePath() {
        return propertiesFilePath;
    }
}
