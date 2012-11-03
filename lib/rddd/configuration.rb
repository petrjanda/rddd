require 'singleton'

#
# Use configuration to configure internals of the RDDD
# framework.
#
class Configuration
  include Singleton

  attr_writer :services_namespace, :repositories_namespace

  def services_namespace
    @services_namespace || Object
  end

  def repositories_namespace
    @repositories_namespace || Object
  end
end