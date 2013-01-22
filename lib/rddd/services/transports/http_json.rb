require 'httpclient'

module Rddd
  module Services
    module Transports
      class HttpJson
        def initialize(attributes)
          @endpoint = attributes[:endpoint]
        end

        def call(service_name, attributes)
          JSON.parse(
            HTTPClient.new.post("#{@endpoint}#{service_name}", 
              :body => JSON.unparse(attributes), 
              :header => {'Content-Type' => 'application/json'}
            ).body
          )
        end
      end
    end
  end
end