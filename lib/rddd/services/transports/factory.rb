require 'json'
require 'curl'
require 'rddd/services/service'
require 'rddd/services/transports/http_json'

module Rddd
  module Services
    module Transports
      class Factory
        def self.build(namespace)
          remote = Configuration.instance.remote_services.find do |remote|
            remote[:namespace] == namespace
          end

          Transports::HttpJson.new(
            :endpoint => remote[:endpoint]
          )
        end
      end
    end
  end
end