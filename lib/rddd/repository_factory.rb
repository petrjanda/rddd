require 'rddd/repository'
require 'rddd/configuration'

class Rddd::NotExistingRepository < RuntimeError
end

class Rddd::RepositoryFactory
  def self.build(clazz)
    repository_name = "#{clazz.name.split('::').last}Repository"
    ns = Rddd::Configuration.instance.repositories_namespace

    begin
      repository = ns.const_get(repository_name)
    rescue
      raise Rddd::NotExistingRepository unless repository
    end

    repository.new
  end
end