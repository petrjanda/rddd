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
    Rddd.configure do |config|
      config.service_creator = lambda do |name|
        class_name = "#{name.to_s.camel_case}Service"
        Object.const_get(class_name.to_sym)
      end
    end

    ProjectRepository.any_instance.expects(:create)

    ProjectsController.new.create(:id => 1, :name => 'Rddd')
  end  
end