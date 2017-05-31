data = {


    "cluster.uid" => { description: "Cluster ID", default_value: "{{cluster.uid}}", mandatory: 1, editable: 0},
    "cluster.name" => { description: "Cluster name", default_value: "{{cluster.name}}", mandatory: 1, editable: 0}


}

config_params(data)

### services
services({
             'webui' => {name: 'webui', protocol: 'http', port: 9000}
         })
