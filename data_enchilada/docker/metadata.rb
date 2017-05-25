data = {
    "elasticsearch.host" => { description: "Elasticsearch host", default_value: "{{elasticsearch.host}}", mandatory: 0, editable: 1},
    "elasticsearch.port" => { description: "Elasticsearch REST port", default_value: "9200", mandatory: 0, editable: 1},
    "elasticsearch.cluster_name" => { description: "Elasticsearch cluster name. Default value for embadded Elasticsearch id the cluster name", default_value: "{{cluster.name}}", mandatory: 0, editable: 1},
    "cassandra.username" => { description: "Cassandra username", default_value: "cassandra", mandatory: 0, editable: 1},
    "cassandra.password" => { description: "Cassandra password", default_value: "cassandra", mandatory: 0, editable: 1},
}

config_params(data)

### services
services({
             'webui' => {name: 'webui', protocol: 'http', port: 80},
             'ssh' => {title: 'SSH', name: 'ssh', protocol: 'ssh', port: 22},
         })
