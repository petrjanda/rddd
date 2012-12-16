class String
  def camel_case
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    self.split('_').map{|token| token.capitalize}.join
  end
end