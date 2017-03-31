package io.gex.data_enchilada;

import org.apache.avro.Schema;

public enum AvroToCassandraDataType {

    //RECORD, ENUM, ARRAY, MAP, UNION, FIXED, BYTES, NULL;

    STRING("string", "varchar"),
    INT("int", "int"),
    BOOLEAN("boolean", "boolean"),
    LONG("long", "bigint"),
    DOUBLE("double", "double"),
    FLOAT("float", "float");

    private String name;
    private String value;

    AvroToCassandraDataType(String name, String value) {
        this.name = name.toLowerCase();
        this.value = value;
    }

    public static String getValue(Schema.Type type) {
        for (AvroToCassandraDataType item : values()) {
            if (item.name.equals(type.getName())) return item.value;
        }
        throw new IllegalArgumentException("Failed to parse " + type.getName() + " to Cassandra data type.");
    }

}
