data = {
    "elasticsearch.host" => { description: "Elasticsearch host", default_value: "{{elasticsearch.host}}", mandatory: 1, editable: 1},
    "elasticsearch.port" => { description: "Elasticsearch port (NOT! REST port)", default_value: "9300", mandatory: 1, editable: 1},
    "elasticsearch.cluster_name" => { description: "Elasticsearch cluster name. Default value for embadded Elasticsearch id the cluster name", default_value: "{{cluster.name}}", mandatory: 1, editable: 1}
}

config_params(data)

### services
services({
             'webui' => {name: 'Web UI', protocol: 'http', port: 80},
             'ssh' => {title: 'SSH', name: 'ssh', protocol: 'ssh', port: 22},
         })
