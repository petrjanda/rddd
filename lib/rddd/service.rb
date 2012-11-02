class Service
  def initialize(attributes)
    @attributes = attributes
  end

  def execute
    raise NotImplementedError  
  end
end