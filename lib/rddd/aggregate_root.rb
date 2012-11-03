require 'rddd/entity'
require 'rddd/repository_factory'
require 'rddd/aggregate_root_finders'

class Rddd::AggregateRoot < Rddd::Entity
  extend Rddd::AggregateRootFinders

  finder :find_by_id

  [:create, :update, :delete].each do |action|
    define_method action do
      self.class.repository.send(action, self)  
    end
  end
end