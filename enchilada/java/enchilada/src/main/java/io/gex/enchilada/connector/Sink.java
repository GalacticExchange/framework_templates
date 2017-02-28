package io.gex.enchilada.connector;

public interface Sink {

    String TEMPLATE_PATH = "/etc/enchilada/templates/";

    void checkConfig() throws Exception;

    String getPropertiesFilePath();
}
