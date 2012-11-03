require 'rddd/service_factory'

class InvalidService < RuntimeError; end

#
# Service bus is the central entry point for execution of service within the
# domain layer. Unless you have a very good reason, services should not be
# instantiated directly outside the domain layer, as you leave the flexibility
# on domain itself to choose the correct implementation.
#
#
# ## Usage
#
# Service bus as the module could be included to any object which intend to
# call services within the domain layer.
#
#
# ## Example
#
# class ProjectsController
#   include ServiceBus
#
#   def create
#     execute(:create_project, params) do |errors|
#       render :new, :errors => errors
#       return
#     end
#
#     redirect_to projects_path, :notice => 'Project was successfully created!'
#   end
# end 
#
#
module ServiceBus
  #
  # Execute the given service.
  #
  # @param {Symbol} Service to be executed.
  # @param {Hash} Attributes to be passed to the service call.
  # @param {Block} Optional error callback block.
  #
  def execute(service_name, attributes = {})    
    raise InvalidService unless service = build_service(service_name, attributes)

    unless service.valid?
      yield(service.errors) and return if block_given?
    end

    service.execute
  end

  private

  def build_service(service_name, attributes)
    ServiceFactory.build(service_name, attributes)
  end
end