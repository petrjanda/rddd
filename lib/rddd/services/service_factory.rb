require 'rddd/configuration'

module Rddd
  module Services
    class ServiceFactory
      StrategyNotGiven = Class.new(RuntimeError)

      InvalidService = Class.new(RuntimeError)

      def self.build(name, attributes)
        strategy = Configuration.instance.service_factory_strategy

        raise StrategyNotGiven unless strategy

        begin
          strategy.call(name).new(attributes)
        rescue
          raise Rddd::Services::ServiceFactory::InvalidService
        end
      end
    end
  end
end