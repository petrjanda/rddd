require 'singleton'

#
# Use configuration to configure internals of the RDDD
# framework.
#
module Rddd
  class Configuration
    include Singleton

    attr_accessor :service_factory_strategy, 
      :repository_creator,
      :caching_strategy,
      :remote_services
  end
end