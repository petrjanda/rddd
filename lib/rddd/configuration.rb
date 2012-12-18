require 'singleton'

#
# Use configuration to configure internals of the RDDD
# framework.
#
module Rddd
  class Configuration
    include Singleton

    attr_writer :service_creator, :repository_creator

    def service_creator
      @service_creator
    end

    def repository_creator
      @repository_creator
    end
  end
end