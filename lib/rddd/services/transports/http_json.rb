module Rddd
  module Services
    module Transports
      class HttpJson
        def initialize(attributes)
          @endpoint = attributes[:endpoint]
        end

        def call(service_name, attributes)
          JSON.parse(Curl.post("#{@endpoint}#{service_name}", JSON.unparse(attributes)) do |http|
            http.headers['Content-Type'] = 'application/json' 
          end.body_str)
        end
      end
    end
  end
end