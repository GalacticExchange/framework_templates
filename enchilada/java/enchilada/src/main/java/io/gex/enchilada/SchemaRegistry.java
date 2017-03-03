package io.gex.enchilada;

import io.confluent.kafka.schemaregistry.client.CachedSchemaRegistryClient;
import io.confluent.kafka.schemaregistry.client.SchemaMetadata;
import io.confluent.kafka.schemaregistry.client.SchemaRegistryClient;
import org.apache.avro.Schema;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class SchemaRegistry {

    private final static Logger logger = LogManager.getLogger(SchemaRegistry.class);

    public static Schema getSchema(String schemaName) throws Exception {
        try {
            //todo why should I care about number of versions SchemaRegistry cloud handle in identityMapCapacity ?????
            SchemaRegistryClient schemaRegistryClient = new CachedSchemaRegistryClient(
                    Enchilada.properties.getProperty(PropertiesReader.SCHEMAREGISTRY), Integer.MAX_VALUE);
            SchemaMetadata schemaMetadata = schemaRegistryClient.getLatestSchemaMetadata(schemaName);
            Schema schema = schemaRegistryClient.getByID(schemaMetadata.getId());
            if (schema == null) {
                //todo can it be null?
                throw new Exception("Schema is null.");
            }
            return schema;
        } catch (Throwable e) {
            logger.error("Failed to get schema for " + schemaName + ".", e);
            throw e;
        }
    }

}
