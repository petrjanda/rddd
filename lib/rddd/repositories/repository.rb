#
# Repository base class.
#
module Rddd
  module Repositories
    class Base
      def create(subject)
        raise NotImplementedError
      end

      def update(subject)
        raise NotImplementedError
      end

      def delete(subject)
        raise NotImplementedError
      end
    end
  end
end