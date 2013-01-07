require 'rddd/presenters/cacheable'
require 'rddd/presenters/cache_entry'

module Rddd
  module Presenters
    class View
      attr_reader :id

      def initialize(id)
        @id = id
      end

      def data
        build
      end

      private

      def build
        raise NotImplementedError
      end
    end
  end
end