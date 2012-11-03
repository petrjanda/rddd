require 'rddd/configuration'

module Rddd
  class ServiceFactory
    def self.build(name, attributes)
      class_name = "#{camel_case(name.to_s)}Service"
      ns = Configuration.instance.services_namespace

      ns.const_get(class_name.to_sym).new(attributes)
    end

    def self.camel_case(string)
      return string if string !~ /_/ && string =~ /[A-Z]+.*/
      string.split('_').map{|e| e.capitalize}.join
    end
  end
end