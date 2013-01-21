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
      def initialize(transport, service_name, attributes)
        super(attributes)

        @transport = transport
        @service_name = service_name
      end

      def execute
        @transport.call(@service_name, @attributes)
      end

      def self.build(namespace, service_name, attributes = {})
        remote = Configuration.instance.remote_services.find do |item|
          item[:namespace] == namespace
        end

        transport = Transports::HttpJson.new(:endpoint => @endpoint)
        RemoteService.new(transport, service_name, attributes)
      end
    end
  end
end