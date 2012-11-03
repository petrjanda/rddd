class ServiceFactory
  def self.build(name, attributes)
    class_name = "#{camel_case(name.to_s)}Service"

    Object.const_get(class_name.to_sym).new(attributes)
  end

  def self.camel_case(string)
    return string if string !~ /_/ && string =~ /[A-Z]+.*/
    string.split('_').map{|e| e.capitalize}.join
  end
end