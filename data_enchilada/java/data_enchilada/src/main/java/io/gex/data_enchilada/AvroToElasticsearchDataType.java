package io.gex.data_enchilada;

import org.apache.avro.Schema;

public enum AvroToElasticsearchDataType {

    // keyword, short, byte, date, binary, integer_range, float_range, long_range, double_range, date_range,
    // type, object, nested, geo_point, geo_shape, ip, completion, token_count, murmur3

    STRING("string", "text"),
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

    public String get(){
        return value;
    }

    public static String getValue(Schema.Type type) {
        for (AvroToElasticsearchDataType item : values()) {
            if (item.name.equals(type.getName())) return item.value;
        }
        throw new IllegalArgumentException("Failed to parse " + type.getName() + " to Elasticsearch data type.");
    }

}
