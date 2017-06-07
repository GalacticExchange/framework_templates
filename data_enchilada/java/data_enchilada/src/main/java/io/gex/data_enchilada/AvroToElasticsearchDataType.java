package io.gex.data_enchilada;

import org.apache.avro.Schema;

public enum AvroToElasticsearchDataType {

    // for elastic 2.4.5

    STRING("string", "string"),
    INT("int", "integer"),
    BOOLEAN("boolean", "boolean"),
    LONG("long", "long"),
    DOUBLE("double", "double"),
    FLOAT("float", "float");

    private String name;
    private String value;

    AvroToElasticsearchDataType(String name, String value) {
        this.name = name.toLowerCase();
        this.value = value;
    }

    public String get() {
        return value;
    }

    public static String getValue(Schema.Type type) {
        for (AvroToElasticsearchDataType item : values()) {
            if (item.name.equals(type.getName())) return item.value;
        }
        throw new IllegalArgumentException("Failed to parse " + type.getName() + " to Elasticsearch data type.");
    }

}
