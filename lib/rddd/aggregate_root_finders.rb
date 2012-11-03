module Rddd::AggregateRootFinders
  def finder(name)
    define_singleton_method name do |*args|
      repository.send(name, *args)
    end
  end

  def repository
    Rddd::RepositoryFactory.build(self)
  end
end