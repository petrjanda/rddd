module Rddd
  module Views
    class View
      attr_reader :id

      class << self
        attr_reader :cache_disabled, :timeout

        def cache(attributes)
          @cache_disabled = attributes.has_key?(:enabled) ? !attributes[:enabled] : false
          @timeout = attributes.has_key?(:timeout) ? 60 * attributes[:timeout] : nil
        end
      end

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
        update_chache(data)

        data
      end

      def invalidate
        repository.set(cache_id, nil)
      end

      def warm_cache
        update_chache(build)
      end

      private

      def cache_id
        "#{name}#{id}"
      end

      def read_cache
        repository.get(cache_id) if repository
      end

      def update_chache(data)
        expire_at = self.class.timeout ? Time.now + self.class.timeout : nil

        repository.set(cache_id, data, expire_at) if repository
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