package io.gex.enchilada;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.zookeeper.ZooKeeper;

import java.util.List;

class KafkaClient {
    private final static Logger logger = LogManager.getLogger(KafkaClient.class);

    static List<String> getTopics() throws Exception {
        logger.trace("Entered " + EnchiladaHelper.getMethodName());
        ZooKeeper zk = null;
        try {
            zk = new ZooKeeper(Enchilada.properties.getProperty(PropertiesReader.ZOOKEEPER), 10000, event -> {});
            List<String> topics = zk.getChildren("/brokers/topics", false);
            topics.removeIf(name -> !name.startsWith("ip"));
            return topics;
        } finally {
            if (zk != null) {
                zk.close();
            }
        }
    }

}
