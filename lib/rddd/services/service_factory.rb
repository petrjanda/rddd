require 'rddd/configuration'

module Rddd
  module Services
    class ServiceFactory
      CreatorNotGiven = Class.new(RuntimeError)

      InvalidService = Class.new(RuntimeError)

      def self.build(name, attributes)
        creator = Configuration.instance.service_creator

        raise CreatorNotGiven unless creator

        begin
          creator.call(name).new(attributes)
        rescue
          raise Rddd::Services::ServiceFactory::InvalidService
        end
      end
    end
  end
end