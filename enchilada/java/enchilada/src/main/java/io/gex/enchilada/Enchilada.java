package io.gex.enchilada;

import io.gex.enchilada.connector.Connector;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

// only for one instance of each sink
public class Enchilada {
    //todo not standalone
    //todo web server to remove connectors
    private final static Logger logger = LogManager.getLogger(Enchilada.class);
    public static Properties properties = new Properties();
    public static String configDir = "/data/enchilada/connectors";

    public static void main(String[] args) {
        logger.trace("Entered " + EnchiladaHelper.getMethodName());
        init();
        while (true) {
            try {
                List<String> topics = KafkaClient.getTopics();
                List<String> currentTopics = EnchiladaTask.getCurrentTopicList();

                // remove connectors that are not present
                List<String> topicsToRemove = new ArrayList<>(currentTopics);
                topicsToRemove.removeAll(topics);
                for (String topic : topicsToRemove) {
                    // remove does't throw exceptions
                    EnchiladaTask.tasks.get(topic).remove();
                }

                currentTopics = EnchiladaTask.getCurrentTopicList();

                // add new connectors
                List<String> topicsToAdd = new ArrayList<>(topics);
                topicsToAdd.removeAll(currentTopics);
                List<Connector> connectors = Connector.generate(topicsToAdd);
                for (Connector connector : connectors) {
                    // add does't throw exceptions
                    EnchiladaTask.add(connector);
                }

                // sleep for 5 minutes
                EnchiladaHelper.sleep(300000);
            } catch (Throwable e) {
                logger.error(e.getMessage(), e);
                EnchiladaHelper.sleep();
            }
        }
    }

    private static void init() {
        logger.trace("Entered " + EnchiladaHelper.getMethodName());
        while (true) {
            try {
                properties = PropertiesReader.read();
                break;
            } catch (Throwable e) {
                logger.error("Failed to read properties file " + PropertiesReader.PROPERTIES_FILENAME + ".", e);
                // sleep for 10 minutes
                EnchiladaHelper.sleep(600000);
            }
        }
    }
}
