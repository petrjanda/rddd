require 'rddd/views/cache'
require 'rddd/views/cacheable'

module Rddd
  module Views
    class View
      include Cacheable
      extend Caching

      attr_reader :id

      def initialize(id)
        @id = id
      end

      def name
        self.class.name.downcase.to_sym
      end

      def build
        raise NotImplementedError
      end

      def data
        return build if self.class.cache_disabled

        cached_data = read_cache

        return cached_data if cached_data

        data = build
        update_cache(data)

        data
      end
    end
  end
end