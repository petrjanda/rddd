require 'rddd/configuration'

module Rddd
  class ServiceFactory
    ServiceCreatorNotGiven = Class.new(RuntimeError)

    def self.build(name, attributes)
      creator = Configuration.instance.service_creator

      raise ServiceCreatorNotGiven unless creator

      creator.call(name).new(attributes)
    end
  end
end