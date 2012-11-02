require 'rddd/repository'

class NoDatabaseDriver < RuntimeError
end

class RepositoryFactory
  def self.driver=(driver)
    @driver = driver
  end

  def self.build
    raise NoDatabaseDriver.new unless @driver

    Repository.new(@driver)
  end
end