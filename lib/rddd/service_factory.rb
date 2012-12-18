require 'rddd/configuration'

module Rddd
  class ServiceFactory
    CreatorNotGiven = Class.new(RuntimeError)

    InvalidService = Class.new(RuntimeError)

    def self.build(name, attributes)
      creator = Configuration.instance.service_creator

      raise CreatorNotGiven unless creator

      begin
        creator.call(name).new(attributes)
      rescue
        raise Rddd::ServiceFactory::InvalidService
      end
    end
  end
end