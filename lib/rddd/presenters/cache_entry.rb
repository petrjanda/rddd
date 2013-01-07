module Rddd
  module Presenters
    #
    # Cache object providing several caching methods on top of the chosen
    # strategy.
    #
    class CacheEntry
      def initialize(key, strategy)
        @key = key
        @strategy = strategy
      end

      def delete
        write(nil)
      end

      def read
        @strategy.get(@key)
      end

      def write(data, timeout = nil)
        expire_at = timeout ? Time.now + timeout : nil

        @strategy.set(@key, data, expire_at)
      end
    end
  end
end