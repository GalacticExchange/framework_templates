data = {

    #"master.host" => { description: "Host of hadoop master node", default_value: "{{master.host}}", mandatory: 1, basic: 1, editable: 0,},
    #"master.ip" => { description: "IP of Hadoop master node", default_value: "{{master.ip}}", mandatory: 1, basic: 1, editable: 0,},
    #"slave.ip" => { description: "IP of Hadoop slave node", default_value: "{{slave.ip}}", mandatory: 1, basic: 1, editable: 0,},
}

config_params(data)

### services
services({
             'webui' => {name: 'webui', protocol: 'http', port: 80},
         })
