require 'singleton'

#
# Use configuration to configure internals of the RDDD
# framework.
#
module Rddd
  class Configuration
    include Singleton

    attr_writer :service_creator, :repositories_namespace

    def service_creator
      @service_creator
    end

    def repositories_namespace
      @repositories_namespace || Object
    end
  end
end