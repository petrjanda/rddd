require 'rddd/repository'

class NotExistingRepository < RuntimeError
end

class RepositoryFactory
  def self.build(clazz)
    repository_name = "#{clazz}Repository"
    
    begin
      repository = const_get(repository_name)
    rescue
      raise NotExistingRepository unless repository
    end

    repository.new
  end
end