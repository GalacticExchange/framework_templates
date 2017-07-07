data = {
    "neo4j.host" => {description: "neo4j host", default_value: "{{neo4j.host}}", mandatory: 1, editable: 0},
    "neo4j.port" => {description: "neo4j port", default_value: "{{neo4j.port}}", mandatory: 1, editable: 0}
}

config_params(data)

### services
services({
             'webui' => {name: 'Web UI', protocol: 'http', port: 80},
             'ssh' => {title: 'SSH', name: 'ssh', protocol: 'ssh', port: 22},
         })
