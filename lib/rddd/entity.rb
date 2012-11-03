class Rddd::Entity
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def ==(other)
    @id == other.id
  end
end