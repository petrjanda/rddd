require 'rddd/entity'
require 'rddd/repositories/repository_factory'
require 'rddd/aggregate_root_finders'

module Rddd
  class AggregateRoot < Entity
    extend AggregateRootFinders

    finder :find

    [:create, :update, :delete].each do |action|
      define_method action do
        self.class.repository.send(action, self)  
      end
    end
  end
end