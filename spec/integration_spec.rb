require 'spec_helper'
require 'rddd/service'
require 'rddd/aggregate_root'
require 'rddd/service_bus'
require 'rddd/service'

class Project < Rddd::AggregateRoot
  attr_accessor :name
end

class CreateProjectService < Rddd::Service
  def execute
    project = Project.new(@attributes[:id])
    project.name = @attributes[:name]

    project.create
  end
end

class ProjectRepository
  def create(project)

  end
end

class ProjectsController
  include Rddd::ServiceBus

  def create(params)
    execute_service(:create_project, params)
  end
end

describe 'CreateProject' do
  it 'should call project save' do
    ProjectRepository.any_instance.expects(:create)

    ProjectsController.new.create(:id => 1, :name => 'Rddd')
  end  
end