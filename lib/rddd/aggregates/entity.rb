module Rddd
  module Aggregates
    #
    # Entity is the object with identity, which is unique across the system. Entities
    # are considered equal only in case their identity is equal discregarding rest 
    # of the similarities.
    #
    # rDDD works agnostic to identifier type. String is used by default.
    #
    # Lets create a model of flat and rooms with some basic calculations:
    #
    #   class Room < Entity
    #     def initialize(id, rooms)
    #       super(id)
    #
    #       @rooms = rooms
    #     end
    #   end
    #
    #   # (see AggregateRoot)
    #   class Flat < AggregateRoot 
    #     attr_reader :size
    #
    #     def initialize(id, size)
    #       super(id)
    #
    #       @size = size
    #     end
    #
    #     def size
    #       @rooms.reduce(0) {|total, room| total += room.size }
    #     end
    #   end
    #
    #   rooms = []
    #   rooms << Room.new('kitchen', 15)
    #   rooms << Room.new('living room', 35)
    #   rooms << Room.new('bed room', 20)
    #
    #   flat = Flat.new('A12TY83', rooms)
    #   
    #   flat.size #= 70
    #
    # As you can see Room entity has its identity (room name) which although isn't
    # global, but local to the given flat instead. Its natural way how we seem rooms.
    # We always identify flat/house first and then room within it. Maintaining global
    # identity is sometimes overkill. Local identity can do just fine.
    #
    class Entity

      #
      # Entity unique identifier.
      #
      attr_reader :id

      #
      # Create entity with given identity.
      #
      # @param [String] Entity identity.
      #
      def initialize(id)
        @id = id
      end

      #
      # Compare two entities for equality.
      #
      # @param [Entity] Entity to compare with.
      #
      def ==(other)
        @id == other.id
      end
    end
  end
end