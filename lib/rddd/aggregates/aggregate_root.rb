require 'rddd/entity'
require 'rddd/repositories/repository_factory'
require 'rddd/aggregates/finders'

module Rddd
  module Aggregates
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