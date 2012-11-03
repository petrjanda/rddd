class ServiceFactory
  def self.build(name, attributes)
    class_name = "#{name.capitalize}Service"
    
    const_get(class_name.to_sym).new(attributes)
  end
end