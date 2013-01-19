require 'rddd/services/service_factory'
require 'rddd/services/remote_service'

module Rddd
  #
  # Service bus is the central entry point for execution of service within the
  # domain layer. Unless you have a very good reason, services should not be
  # instantiated directly outside the domain layer, as you leave the flexibility
  # on domain itself to choose the correct implementation.
  #
  #
  # ## Usage
  #
  # Service bus as the module could be included to any object which intend to
  # call services within the domain layer.
  #
  #
  # ## Example
  #
  # class ProjectsController
  #   include ServiceBus
  #
  #   def create
  #     execute(:create_project, params) do |errors|
  #       render :new, :errors => errors
  #       return
  #     end
  #
  #     redirect_to projects_path, :notice => 'Project was successfully created!'
  #   end
  # end 
  #
  #

  module Services
    module ServiceBus
      #
      # Execute the given service.
      #
      # @param [Symbol] service to be executed.
      # @param [Hash] attributes to be passed to the service call.
      # @param [Block] optional error callback block.
      #
      def execute_service(service_name, attributes = {})
        namespace, service_name = service_name.to_s.split('__') if service_name.to_s.include?('__')

        service = namespace ? \
          build_remote_service(namespace.to_sym, service_name.to_sym, attributes) : \
          build_service(service_name, attributes)

        unless service.valid?
          yield(service.errors) if block_given?
          return
        end

        service.execute
      end

      private

      def build_service(service_name, attributes)
        ServiceFactory.build(service_name, attributes)
      end

      def build_remote_service(namespace, service_name, attributes)
        RemoteService.build(namespace, service_name, attributes)
      end
    end
  end
end