data = {
    "neo4j.host" => {description: "neo4j host", default_value: "{{neo4j.host}}", mandatory: 1, editable: 1},
    "neo4j.port" => {description: "neo4j port", default_value: "{{neo4j.port}}", mandatory: 1, editable: 1}
}

config_params(data)

### services
services({
             'webui' => {name: 'Web UI', protocol: 'http', port: 80},
             'ssh' => {title: 'SSH', name: 'ssh', protocol: 'ssh', port: 22},
         })

app_info = {
    metrics: {
        graph_ide: {
            memory: 0.5,
            hdd: 1.0
        }
    },
    dependencies: {
        components: [:neo4j],
        containers: []
    }
}