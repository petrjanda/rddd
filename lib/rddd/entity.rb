class Entity
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def ==(b)
    @id == b.id
  end
end