#
# Service is the object to represent a single use case. Service is usually good
# entry point to the system domain. Its responsibility is to orchestrate the
# cooperation of multiple entities, in a given order defined by use case.
#
# Service takes a list of attributes, which are necessary to execute the given
# use case. At the end nothing is returned, so service represent the command to
# the domain, but doesn't return any data back.
#
class Service
  def initialize(attributes = {})
    @attributes = attributes
  end

  def valid?
    true
  end

  def execute
    raise NotImplementedError  
  end
end