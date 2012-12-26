require 'rddd/entity'
require 'rddd/repositories/repository_factory'
require 'rddd/aggregates/finders'

module Rddd
  module Aggregates
    #
    # Domain model Entities (see Entity#initialize) are organized to clusters
    # called Aggregates. Every Aggregate should have its Root. Aggregate Root
    # should be only entity from Aggregate visible from outside to guarantee
    # consistency of all operations performed on the given Aggregate.
    #
    class AggregateRoot < Entity
      extend Finders

      finder :find

      [:create, :update, :delete].each do |action|
        define_method action do
          self.class.repository.send(action, self)  
        end
      end
    end
  end
end