data = {
    "elasticsearch.host" => { description: "Elasticsearch host", default_value: "{{elasticsearch.host}}", mandatory: 1, editable: 1},
    "elasticsearch.port" => { description: "Elasticsearch port (NOT! REST port)", default_value: "9300", mandatory: 1, editable: 1},
    "elasticsearch.cluster_name" => { description: "Elasticsearch cluster name. Default value for embadded Elasticsearch id the cluster name", default_value: "{{cluster.name}}", mandatory: 1, editable: 1},
    "elasticsearch.index_name" => { description: "Elasticsearch index name", default_value: "scraper", mandatory: 1, editable: 1},
    "scrap.urls" => { description: "URLs for scrapping (please separate with ,)", default_value: "http://galacticexchange.io/", mandatory: 1, editable: 1},
    "scrap.num_rounds" => { description: "The number of rounds to scrap", default_value: "2", mandatory: 1, editable: 1},
    "scrap.interval" => { description: "Time between scrapping in seconds (1m - minute, 1h - hour)", default_value: "1h", mandatory: 1, editable: 1},
    "scrap.extract_article" => { description: "Extract articles from pages", default_value: "false", mandatory: 1, editable: 1},
}

config_params(data)

### services
services({
             'ssh' => {title: 'SSH', name: 'ssh', protocol: 'ssh', port: 22},
         })
