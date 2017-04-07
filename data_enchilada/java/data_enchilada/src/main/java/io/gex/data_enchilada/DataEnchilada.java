package io.gex.data_enchilada;

import io.gex.data_enchilada.connector.Connector;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class DataEnchilada {
    //todo not standalone
    //todo only for one instance of each sink
    private final static Logger logger = LogManager.getLogger(DataEnchilada.class);
    public static Properties properties = new Properties();
    public static String configDir = "/data/data_enchilada/connectors";

    public static void main(String[] args) {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        init();
        Runtime.getRuntime().addShutdownHook(new Thread(() -> DataEnchiladaTask.processes.forEach(Process::destroyForcibly)));
        while (true) {
            try {
                List<String> topics = KafkaClient.getTopics();
                List<String> currentTopics = DataEnchiladaTask.getCurrentTopicList();

                // remove connectors that are not present
                List<String> topicsToRemove = new ArrayList<>(currentTopics);
                topicsToRemove.removeAll(topics);
                for (String topic : topicsToRemove) {
                    // remove does't throw exceptions
                    DataEnchiladaTask.tasks.get(topic).remove();
                    logger.info(topic + " connector removed.");
                }

                currentTopics = DataEnchiladaTask.getCurrentTopicList();

                // add new connectors
                List<String> topicsToAdd = new ArrayList<>(topics);
                topicsToAdd.removeAll(currentTopics);
                if (topicsToAdd.size() != 0) {
                    List<Connector> connectors = Connector.generate(topicsToAdd);
                    for (Connector connector : connectors) {
                        // add does't throw exceptions
                        DataEnchiladaTask.add(connector);
                    }
                }
                logger.info("Topics total: " + DataEnchiladaTask.getCurrentTopicList().size() + ".");
                // sleep for 5 minutes
                DataEnchiladaHelper.sleep(300000);
            } catch (Throwable e) {
                logger.error(e.getMessage(), e);
                // sleep for 5 minutes
                DataEnchiladaHelper.sleep(300000);
            }
        }
    }

    private static void init() {
        logger.trace("Entered " + DataEnchiladaHelper.getMethodName());
        while (true) {
            try {
                properties = PropertiesReader.read();
                break;
            } catch (Throwable e) {
                logger.error("Failed to read properties file " + PropertiesReader.PROPERTIES_FILENAME + ".", e);
                // sleep for 10 minutes
                DataEnchiladaHelper.sleep(600000);
            }
        }
        try {
            List<String> topics = KafkaClient.getTopics();
            //select last used rest port
            for (String topic : topics) {
                File file = new File(Connector.generateSchemaPropertiesFilePath(topic));
                if (!file.exists()) {
                    Properties properties = new Properties();
                    try (FileInputStream fileStream = new FileInputStream(file);
                         InputStreamReader inputStreamReader = new InputStreamReader(fileStream, StandardCharsets.UTF_8)) {
                        properties.load(inputStreamReader);
                        if (Integer.valueOf(properties.getProperty("rest.port")) > Connector.currentPort) {
                            Connector.currentPort = Integer.valueOf(properties.getProperty("rest.port"));
                        }
                    }
                }
            }
        } catch (Throwable e) {
            logger.error(e.getMessage(), e);
            //continue
        }
        logger.info("Current rest port: " + Connector.currentPort);
    }
}
