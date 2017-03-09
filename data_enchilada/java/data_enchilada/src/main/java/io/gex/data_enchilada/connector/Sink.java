package io.gex.data_enchilada.connector;

public interface Sink {

    String TEMPLATE_PATH = "/etc/data_enchilada/templates/";

    void checkConfig() throws Exception;

    String getPropertiesFilePath();
}
