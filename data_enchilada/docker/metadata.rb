data = {
    "elasticsearch.host" => { description: "Elasticsearch host", default_value: "{{elasticsearch.host}}", mandatory: 0, editable: 1},
    "elasticsearch.port" => { description: "Elasticsearch REST port", default_value: "9200", mandatory: 0, editable: 1},
    "kafka.host" => { description: "Kafka host", default_value: "{{kafka.host}}", mandatory: 0, editable: 1},
    "kafka.port" => { description: "Kafka port", default_value: "9092", mandatory: 0, editable: 1},
    "zookeeper.host" => { description: "Zookeper host", default_value: "{{zookeeper.host}}", mandatory: 0, editable: 1},
    "zookeeper.port" => { description: "Zookeper port", default_value: "2181", mandatory: 0, editable: 1},
    "cassandra.host" => { description: "Cassandra host", default_value: "{{cassandra.host}}", mandatory: 0, editable: 1},
    "cassandra.port" => { description: "Cassandra port", default_value: "9042", mandatory: 0, editable: 1},
    "cassandra.username" => { description: "Cassandra username", default_value: "cassandra", mandatory: 0, editable: 1},
    "cassandra.password" => { description: "Cassandra password", default_value: "cassandra", mandatory: 0, editable: 1},
    "hdfs.host" => { description: "HDFS host", default_value: "{{hdfs.host}}", mandatory: 0, editable: 1},
    "hdfs.port" => { description: "HDFS port", default_value: "50070", mandatory: 0, editable: 1},
    "kudu.master.host" => { description: "Kudu master host", default_value: "{{master.host}}", mandatory: 0, editable: 1},
    "kudu.master.port" => { description: "Kudu master port", default_value: "7051", mandatory: 0, editable: 1},
    "impala.host" => { description: "Impala host", default_value: "{{master.host}}", mandatory: 0, editable: 1},
    "impala.port" => { description: "Impala port", default_value: "21000", mandatory: 0, editable: 1},

}

#todo use predefine ports
config_params(data)

### services
services({
             'webui' => {name: 'webui', protocol: 'http', port: 80},
             'data_collector' => {name: 'data_collector', protocol: 'tcp', port: 24224},
             'ssh' => {title: 'SSH', name: 'ssh', protocol: 'ssh', port: 22},
         })


app_info = {
    metrics: {
        data_enchilada: {
            memory: 0.45,
            hdd: 2.31
        }
    },
    dependencies: {
        components: [],
        containers: []
    }
}

app_info(app_info)