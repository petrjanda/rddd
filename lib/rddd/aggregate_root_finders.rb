module Rddd
  module AggregateRootFinders
    def finder(name)
      define_singleton_method name do |*args|
        repository.send(name, *args)
      end
    end

    def repository
      RepositoryFactory.build(self)
    end
  end
end