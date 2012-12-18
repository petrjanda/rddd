require 'rddd/repository'
require 'rddd/configuration'

module Rddd
  class NotExistingRepository < RuntimeError
  end

  class RepositoryFactory
    CreatorNotGiven = Class.new(RuntimeError)

    def self.build(clazz)
      creator = Configuration.instance.repository_creator

      raise CreatorNotGiven unless creator

      begin
        repository = creator.call(clazz)
      rescue
        raise NotExistingRepository unless repository
      end

      repository.new
    end
  end
end