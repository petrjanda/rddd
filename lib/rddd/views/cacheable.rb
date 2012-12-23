module Rddd
  module Views
    module Caching
      attr_reader :cache_disabled, :timeout

      def cache(attributes)
        @cache_disabled = attributes.has_key?(:enabled) ? !attributes[:enabled] : false
        @timeout = attributes.has_key?(:timeout) ? 60 * attributes[:timeout] : nil
      end
    end

    module Cacheable
      def invalidate
        cache.invalidate if cache
      end

      def warm_cache
        update_cache(build)
      end

      private

      def read_cache
        cache.read if cache
      end

      def update_cache(data)
        cache.write(data, self.class.timeout) if cache
      end

      def cache
        nil unless repository

        @cache ||= Cache.new(cache_id, repository)
      end

      def cache_id
        "#{name}#{id}"
      end

      def repository
        begin
          @repository ||= ViewRepository.new
        rescue
          nil 
        end
      end
    end
  end
end