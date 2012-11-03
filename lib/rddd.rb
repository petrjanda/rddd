require 'rddd/version'
require 'rddd/configuration'

module Rddd
  #
  # Configure Rddd framework.
  #
  # ## Usage
  #
  # Rddd.configure do |config|
  #   config.services_namespace = Rddd::Services
  # end
  #
  def self.configure
    yield(Rddd::Configuration.instance)
  end
end