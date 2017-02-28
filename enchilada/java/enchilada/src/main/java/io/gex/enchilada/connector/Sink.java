package io.gex.enchilada.connector;

public interface Sink {

    String TEMPLATE_PATH = "/etc/enchilada/template/";

    void checkConfig() throws Exception;

    String getPropertiesFilePath();
}
