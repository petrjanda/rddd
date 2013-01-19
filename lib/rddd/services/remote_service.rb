require 'curb'
require 'rddd/services/service'

module Rddd
  module Services
    class RemoteService < Service
      def initialize(url, attributes = {})
        super(attributes)

        @url = url
      end

      def execute
        Curl.post(@url, @attributes).body_str
      end

      def self.build(namespace, service_name, attributes)
        remote = Configuration.instance.remote_services.find do |item|
          item[:namespace] == namespace
        end

        RemoteService.new("#{remote[:endpoint]}#{service_name}", attributes)
      end
    end
  end
end