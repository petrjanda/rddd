module Rddd
  module Presenters
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
    #   class ProjectsView < Rddd::Presenters::Presenter
    #     extend Rddd::Presenters::Cacheable
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
    # ## Timeout
    #
    # By default, there is no expiration to the values you store in the cache.
    # This means, value is theoretically stored for infinite time or until some
    # purging mechanism clean the code from cache as the less queried one.
    #
    # If you want to have more control of when the certain key should be removed
    # you can use :timeout option. Its configurable per view.
    #
    #   class ProjectsView < Rddd::Presenters::Presenter
    #     extend Rddd::Presenters::Cacheable
    #
    #      cache :timeout => 60 * 24
    #    end
    #
    # Above call to ```cache``` with timeout changed its behavior. Each key for a given
    # view now expires in 24 * 60 minutes, therefore in a day from its creation.
    #
    # ## Serialization
    #
    # By default cache does no serialization so in general String values are expected
    # as caches almost exclusively work with Strings. You can inject serializor with
    # cache configuration.
    #
    #   class ProjectsView < Rddd::Presenters::Presenter
    #     extend Rddd::Presenters::Cacheable
    #
    #      cache :serializer => Marshal
    #    end
    #
    # Above would call ```Marshal::dump``` each time before write to cache and
    # ```Marshal::load``` each time the value is retrieved from it.
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
        __read__ || __update__(build)
      end

      private

      def __read__
        data = __cache__.read

        return nil unless data
        
        self.class.serializer ? self.class.serializer::load(data) : data
      end

      def __update__(data)
        data = self.class.serializer::dump(data) if self.class.serializer

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
      attr_reader :timeout, :serializer

      def cache(attributes)
        @timeout = attributes.fetch(:timeout, nil)
        @timeout = @timeout && 60 * @timeout
        @serializer = attributes.fetch(:serializer, nil)
      end
    end
  end
end