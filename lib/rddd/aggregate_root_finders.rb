module Rddd
  module AggregateRootFinders
    def finder(name, &block)
      (class << self; self; end).instance_eval do
        define_method name do |*args|
          repository.send(name, *args)
        end
      end
    end

    def repository
      RepositoryFactory.build(self)
    end
  end
end