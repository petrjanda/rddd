module Rddd
  module Views
    #
    # View extension, which would make it cacheable. In case you wanna use it
    # be sure to have a CacheStrategy set in the configuration. As soon as you
    # include the module, View is gonna start caching without any timeout.
    #
    # Here is how you configure your caching with simple strategy:
    #
    #   class InMemoryStrategy
    #     def get(key)
    #       @entries[key]
    #     end
    #
    #     def set(key, value, options)
    #       @entries ||= {}
    #       @entries[key] = value
    #     end
    #   end
    #
    #   Rddd.configure do |config|
    #     config.cache_strategy = InMemoryStrategy.new
    #   end
    #
    #
    # Each time you hit data method, cache is first checked for presence of the
    # data and if none is there build method is called to compose the view,
    # result is updated to the cache and returned.
    #
    # Usage:
    #
    #   class ProjectsView < Rddd::Views::View
    #     extend Rddd::Views::Cacheable
    #
    #     def build
    #       Projects.find_by_account_id(@id).map { |project| format(project) }
    #     end
    #
    #     def format(project)
    #       {
    #         :name => project.name,
    #         :deathline => project.deathline.strftime("%d %B %Y")
    #       }
    #     end
    #   end
    #
    # ProjectsView.new(account_id).data #= [{:name => 'Rddd', :deathline => '01 January 2013'}]
    #
    # Second time value is requested, the cache is hit and build is not called
    # again.
    #
    module Cacheable
      def self.included(base)
        base.extend CacheableConfig
      end

      def self.extended(base)
        base.class.extend CacheableConfig
      end

      #
      # Invalidate the given view so next time its requested no cached value
      # would be given.
      #
      def invalidate
        __cache__.delete
      end

      #
      # Trigger the warming up of the cache for a given view.
      #
      def warm_up
        __update__(build)
      end

      def data
        __cache__.read || __update__(build)
      end

      private

      def __update__(data)
        __cache__.write(data, self.class.timeout)

        data
      end

      def __cache__
        CacheEntry.new(
          "#{self.class.name.downcase.to_sym}#{id}", 
          @strategy ||= Configuration.instance.caching_strategy
        )
      end
    end

    module CacheableConfig
      attr_reader :timeout

      def cache(attributes)
        @timeout = attributes.fetch(:timeout, nil)
        @timeout = @timeout && 60 * @timeout
      end
    end
  end
end