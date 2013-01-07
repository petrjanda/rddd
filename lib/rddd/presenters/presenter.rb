require 'rddd/presenters/cacheable'
require 'rddd/presenters/cache_entry'

module Rddd
  #
  # Presenter is simply a view on the domain data. Presenters should be used
  # each time, you are about to get some data out of the domain. The result
  # returned from presenter should be either very dumb DTO (data transfer object)
  # or one of the base data types like Array, Hash or even some scalar value.
  #
  # Key goal is to make a clear boundary to the domain, so none full fledged
  # business object is leaked outside of it.
  #
  # Presenter output is composed inside ```build``` method, which is called each
  # time someone tries to access view ```data```. Lets take a look at simple example:
  #
  #   class EventsByCityAndDatePresenter < Rddd::Presenters::View
  #     def initialize(city_id, date)
  #       @city_id = city_id
  #       @date = date
  #       
  #       super("#{city_id}-#{date}")
  #     end
  #
  #     private
  #
  #     def build
  #       format(City.find(@city_id).events_by_date(@date))
  #     end
  #
  #     def format(events)
  #       events.map { |event| {:name => event.name, :time => event.time} }
  #     end
  #   end
  #
  #   EventsByCityAndDatePresenter.new(city_id, Date.today).data #= [{:name => 'Happy new year!', :time => '00:00'}]
  #
  # ## Caching
  #
  # So far we didn't got too many benefits from use of the cache, although
  # because the View made a clear boundary, there are some benefits which
  # we can easily build on top of it. First is the caching. In order to plug
  # it in simply extend Rddd::Presenters::Cacheable. See its documentation.
  #
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