#! /usr/bin/env ruby
#
#   metrics-docker-stats
#
# DESCRIPTION:
#
# Supports the stats feature of the docker remote api ( docker server 1.5 and newer )
# Supports connecting to docker remote API over Unix socket or TCP
#
#
# OUTPUT:
#   metric-data
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   Gather stats from all containers on a host using socket:
#   metrics-docker-stats.rb -p unix -H /var/run/docker.sock
#
#   Gather stats from all containers on a host using TCP:
#   metrics-docker-stats.rb -p http -H localhost:2375
#
#   Gather stats from a specific container using socket:
#   metrics-docker-stats.rb -p unix -H /var/run/docker.sock -c 5bf1b82382eb
#
#   See metrics-docker-stats.rb --help for full usage flags
#
# NOTES:
#
# LICENSE:
#   Copyright 2015 Paul Czarkowski. Github @paulczar
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/metric/cli'
require 'socket'
require 'net_http_unix'
require 'docker'


class Hash
  def self.to_dotted_hash(hash, recursive_key = '')
    hash.each_with_object({}) do |(k, v), ret|
      key = recursive_key + k.to_s
      if v.is_a? Hash
        ret.merge! to_dotted_hash(v, key + '.')
      else
        ret[key] = v
      end
    end
  end
end

class DockerStatsMetrics < Sensu::Plugin::Metric::CLI::Graphite

  # options not available
  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         #default: "#{Socket.gethostname}.docker"
         default: "docker"

  option :container,
         description: 'Name of container to collect metrics for',
         short: '-c CONTAINER',
         long: '--container CONTAINER',
         default: ''

  option :docker_host,
         description: 'Docker socket to connect. TCP: "host:port" or Unix: "/path/to/docker.sock" (default: "127.0.0.1:2375")',
         short: '-H DOCKER_HOST',
         long: '--docker-host DOCKER_HOST',
         default: '127.0.0.1:2375'

  option :docker_protocol,
         description: 'http or unix',
         short: '-p PROTOCOL',
         long: '--protocol PROTOCOL',
         default: 'http'

  option :friendly_names,
         description: 'use friendly name if available',
         short: '-n',
         long: '--names',
         boolean: true,
         default: true

  def run
    resp = {
        timestamp: Time.now.to_i,
        containers: { }
    }

    containers = get_running_containers

    containers.each do |container|
      cont_json = container.json
      cont_name = cont_json["Name"].delete('/')
      cont_stats = container.stats
      resp[:containers][cont_name] = cont_stats
    end

    output resp.to_json
    ok
  end

  def get_running_containers
    Docker::Container.all(all: true)
  end

  def get_container(container_name)
    Docker::Container.get(container_name)
  end

end
