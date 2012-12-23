module Rddd
  module Views
    class Cache
      def initialize(id, repository)
        @id = id
        @repository = repository
      end

      def read
        @repository.get(@id) if @repository
      end

      def invalidate
        @repository.set(@id, nil)
      end

      def write(data, timeout)
        expire_at = timeout ? Time.now + timeout : nil

        @repository.set(@id, data, expire_at)
      end
    end
  end
end