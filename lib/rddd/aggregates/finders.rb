module Rddd
  module Aggregates
    module Finders
      def finder(name)
        craete_static_method(name) do |*args|
          repository.send(name, *args)
        end
      end

      def repository
        Repositories::Factory.build(self)
      end

      private

      def craete_static_method(name, &block)
        (class << self; self; end).module_eval do
          define_method name, &block
        end
      end
    end
  end
end