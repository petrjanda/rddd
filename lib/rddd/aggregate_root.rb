require 'rddd/repository_factory'

module AggregateRoot

  [:create, :update, :delete].each do |action|
    define_method action do
      RepositoryFactory.build.send(action, self)  
    end
  end
end