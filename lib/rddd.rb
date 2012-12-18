require 'rddd/version'
require 'rddd/configuration'
require 'core_ext/string'

module Rddd
  #
  # Configure Rddd framework.
  #
  # ## Usage
  #
  #   Rddd.configure do |config|
  #     config.service_creator = lambda do |name|
  #       class_name = "#{name.to_s.camel_case}Service"
  #
  #       Rddd::Services.const_get(class_name.to_sym)
  #     end
  #   end
  #
  def self.configure
    yield(Rddd::Configuration.instance)
  end
end