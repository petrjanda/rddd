require 'rddd/configuration'
require 'rddd/aggregates/repositories/base'

module Rddd
  module Repositories
    class NotExistingRepository < RuntimeError
    end

    #
    # @private
    #
    # Create instance of Repository using the Configration#repository_creator
    # and passing the class along.
    #
    class Factory
      CreatorNotGiven = Class.new(RuntimeError)

      def self.build(clazz)
        creator = Configuration.instance.repository_creator

        raise CreatorNotGiven unless creator

        begin
          repository = creator.call(clazz)
        rescue
          raise NotExistingRepository unless repository
        end

        repository.new
      end
    end
  end
end