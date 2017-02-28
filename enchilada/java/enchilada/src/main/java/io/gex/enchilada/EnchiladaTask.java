package io.gex.enchilada;

import io.gex.enchilada.connector.Connector;
import io.gex.enchilada.connector.Sink;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.LoggerContext;
import org.apache.logging.log4j.core.appender.RollingFileAppender;
import org.apache.logging.log4j.core.appender.rolling.DefaultRolloverStrategy;
import org.apache.logging.log4j.core.appender.rolling.SizeBasedTriggeringPolicy;
import org.apache.logging.log4j.core.config.AppenderRef;
import org.apache.logging.log4j.core.config.Configuration;
import org.apache.logging.log4j.core.config.LoggerConfig;

import java.io.File;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

class EnchiladaTask {

    private final static Logger logger = LogManager.getLogger(EnchiladaTask.class);
    private final static String EXEC_PATH = "/usr/bin/connect-standalone"; //"/home/khotkevych/Downloads/confluent-3.1.2/bin/connect-standalone";
    private final static int bufferSize = 512;
    static Map<String, EnchiladaTask> tasks = new HashMap<>();

    private ExecutorService task;
    private Future<?> taskFuture;
    private String topic;
    private Connector connector;

    private EnchiladaTask(Connector connector) {
        this.task = Executors.newSingleThreadExecutor();
        this.connector = connector;
        this.topic = connector.getTopic();
    }

    static void add(Connector connector) {
        logger.trace("Entered " + EnchiladaHelper.getMethodName());
        if (StringUtils.isBlank(connector.getSinkPropertiesString())) {
            logger.error("No sinks are available for topic " + connector.getTopic() + ". Connector is not started.");
            return;
        }
        EnchiladaTask task = new EnchiladaTask(connector);
        task.start();
        tasks.put(task.topic, task);
    }

    static List<String> getCurrentTopicList() {
        return new ArrayList<>(tasks.keySet());
    }

    private void start() {
        logger.trace("Entered " + EnchiladaHelper.getMethodName());
        taskFuture = task.submit(() -> {
            try {
                ProcessBuilder ps = new ProcessBuilder(Arrays.asList("/bin/bash", "-c", EXEC_PATH + " " +
                        connector.getSchemaPropertiesFilePath() + connector.getSinkPropertiesString()));
                Process p = ps.start();
                InputStream in = p.getInputStream();
                Logger logger = createLogger();
                byte[] buffer = new byte[bufferSize];
                if (in != null) {
                    int i;
                    while ((i = in.read(buffer, 0, bufferSize)) >= 0) {
                        if (i > 0) {
                            String line = new String(buffer, 0, i, StandardCharsets.UTF_8);
                            logger.info(line);
                        }
                    }
                }
                p.waitFor();
            } catch (Throwable e) {
                logger.error(e.getMessage(), e);
            }
        });
    }

    private Logger createLogger() {
        logger.trace("Entered " + EnchiladaHelper.getMethodName());
        if (!LogManager.exists(topic)) {
            LoggerContext context = (LoggerContext) LogManager.getContext(false);
            Configuration configuration = context.getConfiguration();
            SizeBasedTriggeringPolicy policy = SizeBasedTriggeringPolicy.createPolicy("5 MB");
            policy.initialize();
            DefaultRolloverStrategy strategy = DefaultRolloverStrategy.createStrategy("10", "1", "max", null, null, true, configuration);
            String logFilename = "/data/enchilada/connectors/log/" + topic + ".log";
            RollingFileAppender appender = RollingFileAppender.newBuilder().setConfiguration(configuration).withPolicy(policy).
                    withStrategy(strategy).withName(topic).withFileName(logFilename).withFilePattern(logFilename + "-%i.log").build();
            appender.start();
            configuration.addAppender(appender);
            AppenderRef ref = AppenderRef.createAppenderRef(topic, null, null);
            LoggerConfig loggerConfig = LoggerConfig.createLogger(false, Level.INFO, "io.gex.enchilada.connector",
                    "true", new AppenderRef[]{ref}, null, configuration, null);
            loggerConfig.addAppender(appender, Level.INFO, null);
            configuration.addLogger(topic, loggerConfig);
            context.updateLoggers();
        } else {
            logger.info("Logger for " + topic + " topic is already exist.");
        }
        return LogManager.getLogger(topic);
    }

    void remove() {
        logger.trace("Entered " + EnchiladaHelper.getMethodName());
        if (taskFuture != null) {
            taskFuture.cancel(true);
        }
        if (task != null) {
            try {
                task.shutdown();
            } catch (Throwable e) {
                logger.warn(e.getMessage(), e);
            }
        }
        tasks.remove(this.topic);
        FileUtils.deleteQuietly(new File(connector.getSchemaPropertiesFilePath()));
        for (Sink sink : connector.getSinks()) {
            FileUtils.deleteQuietly(new File(sink.getPropertiesFilePath()));
        }
        //remove logging
        try {
            LoggerContext context = (LoggerContext) LogManager.getContext(false);
            Configuration configuration = context.getConfiguration();
            RollingFileAppender appender = configuration.getAppender(topic);
            appender.stop();
            LoggerConfig loggerConfig = configuration.getLoggerConfig(topic);
            loggerConfig.removeAppender(topic);
            configuration.removeLogger(topic);
            context.updateLoggers();
        } catch (Throwable e) {
            logger.warn(e.getMessage(), e);
        }
    }
}
