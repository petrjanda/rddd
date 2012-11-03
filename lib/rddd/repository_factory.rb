require 'rddd/repository'
require 'rddd/configuration'

class NotExistingRepository < RuntimeError
end

class RepositoryFactory
  def self.build(clazz)
    repository_name = "#{clazz}Repository"
    ns = Configuration.instance.repositories_namespace

    begin
      repository = ns.const_get(repository_name)
    rescue
      raise NotExistingRepository unless repository
    end

    repository.new
  end
end