#
# Service is the object to represent a single use case. Service is usually good
# entry point to the system domain. Its responsibility is to orchestrate the
# cooperation of multiple entities, in a given order defined by use case.
#
# Service takes a list of attributes, which are necessary to execute the given
# use case. You shouldn't need to create Service directly. Instead use ServiceBus.
#
# Its good practice to leave your service return-less. Although if you *really* need
# something back from the service for other usage, be sure you return just data in
# form of DTO (Hash, Array of Hashes), but no Entities and AggregateRoot or other
# domain objects, so you dont leak business out.
#
# Remember dummy data goes in, dummy data goes out.
#
module Rddd
  class Service
    def initialize(attributes = {})
      @attributes = attributes
    end

    def valid?
      true
    end

    def execute
      raise NotImplementedError  
    end
  end
end