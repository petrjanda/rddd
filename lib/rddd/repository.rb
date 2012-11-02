#
# Repository base class.
#
class Repository
  def initialize(driver)
    @driver = driver
  end

  private

  attr_reader :driver
end