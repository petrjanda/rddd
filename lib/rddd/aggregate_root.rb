require 'rddd/entity'
require 'rddd/repository_factory'

class AggregateRoot < Entity

  [:create, :update, :delete].each do |action|
    define_method action do
      RepositoryFactory.build(self.class).send(action, self)  
    end
  end
end