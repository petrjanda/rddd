require 'rddd/views/cacheable'
require 'rddd/views/cache_entry'

module Rddd
  module Views
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