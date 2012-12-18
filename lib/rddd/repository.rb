#
# Repository base class.
#
class Rddd::Repository
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