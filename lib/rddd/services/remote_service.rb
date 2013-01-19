require 'json'
require 'curl'
require 'rddd/services/service'

module Rddd
  module Services
    #
    # Remote service is the way to execute logic on different application.
    # Currently JSON encoded, HTTP based transport is supported. In future
    # there is a plan for more generic RPC support.
    #
    # Usage:
    #
    #   # Configure the remote endpoint.
    #   Rddd.configure do |config|
    #     config.remote_services = [
    #       {:namespace => 'projects', :endpoint => 'http://products.dev/'}
    #     ]
    #   end
    #
    #   # Execute service
    #   class Test < Sinatra:Base
    #     get '/:account_id/projects' do
    #       execute_service(:projects__list, params[:account_id])
    #     end
    #   end
    #
    #   # Finally here is the remote app
    #   class Projects < Sinatra:Base
    #     post ':service_name' do
    #       execute_service(params[:service_name], request.body)
    #     end
    #   end
    #
    # As you can see remote app uses the service bus as well. This architecture
    # would allow you pull part of your application to separate box without need
    # for any change in your client or services code base.
    #
    class RemoteService < Service
      def initialize(url, attributes = {})
        super(attributes)

        @url = url
      end

      def execute
        JSON.parse(Curl.post(@url, JSON.unparse(@attributes)) do |http|
          http.headers['Content-Type'] = 'application/json' 
        end.body_str)
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