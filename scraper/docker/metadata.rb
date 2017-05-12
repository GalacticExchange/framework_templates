data = {
    "cluster.uid" => { description: "Cluster ID", default_value: "{{cluster.uid}}", mandatory: 1, editable: 0},
    "cluster.name" => { description: "Cluster name", default_value: "{{cluster.name}}", mandatory: 1, editable: 0},
    "elastic_index_name" => { description: "Elastic Search index name", default_value: "scraper", mandatory: 1, editable: 1},
    "scrap_urls" => { description: "URLs for scrapping (please separate with ,)", default_value: "", mandatory: 1, editable: 1},
    "scrap_domains" => { description: "Domains for scrapping urls (Needs for not to scrap external websites)", default_value: "", mandatory: 1, editable: 1},
    "scrap_num_rounds" => { description: "The number of rounds to scrap", default_value: "2", mandatory: 1, editable: 1},
}

config_params(data)

### services
services({
             'ssh' => {title: 'SSH', name: 'ssh', protocol: 'ssh', port: 22},
         })
