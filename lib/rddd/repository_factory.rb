require 'rddd/repository'
require 'rddd/configuration'

module Rddd
  class NotExistingRepository < RuntimeError
  end

  class RepositoryFactory
    def self.build(clazz)
      repository_name = "#{clazz.name.split('::').last}Repository"
      ns = Configuration.instance.repositories_namespace

      begin
        repository = ns.const_get(repository_name)
      rescue
        raise NotExistingRepository unless repository
      end

      repository.new
    end
  end
end