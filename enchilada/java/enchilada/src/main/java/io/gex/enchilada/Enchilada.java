package io.gex.enchilada;

import io.gex.enchilada.connector.Connector;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class Enchilada {
    //todo not standalone
    //todo only for one instance of each sink
    private final static Logger logger = LogManager.getLogger(Enchilada.class);
    public static Properties properties = new Properties();
    public static String configDir = "/data/enchilada/connectors";

    public static void main(String[] args) {
        logger.trace("Entered " + EnchiladaHelper.getMethodName());
        init();
        Runtime.getRuntime().addShutdownHook(new Thread(() -> EnchiladaTask.processes.forEach(Process::destroyForcibly)));
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
                    logger.info(topic + " connector removed.");
                }

                currentTopics = EnchiladaTask.getCurrentTopicList();

                // add new connectors
                List<String> topicsToAdd = new ArrayList<>(topics);
                topicsToAdd.removeAll(currentTopics);
                if (topicsToAdd.size() != 0) {
                    List<Connector> connectors = Connector.generate(topicsToAdd);
                    for (Connector connector : connectors) {
                        // add does't throw exceptions
                        EnchiladaTask.add(connector);
                    }
                }
                logger.info("Topics total: " + EnchiladaTask.getCurrentTopicList().size() + ".");
                // sleep for 5 minutes
                EnchiladaHelper.sleep(300000);
            } catch (Throwable e) {
                logger.error(e.getMessage(), e);
                // sleep for 5 minutes
                EnchiladaHelper.sleep(300000);
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