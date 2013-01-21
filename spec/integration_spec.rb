require 'spec_helper'
require 'rddd/aggregates/root'
require 'rddd/services/service'
require 'rddd/services/service_bus'
require 'rddd/services/service'

class Project < Rddd::Aggregates::Root
  attr_accessor :name
end

class CreateProjectService < Rddd::Services::Service
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
  include Rddd::Services::ServiceBus

  def create(params)
    execute_service(:create_project, params)
  end
end

describe 'CreateProject' do
  let(:repository_creator) do
    lambda do |name|
      class_name = "#{name.to_s.camel_case}Repository"
      Object.const_get(class_name.to_sym)
    end
  end

  before do
    Rddd.configure do |config|
      config.repository_creator = repository_creator

      config.service_factory_strategy = lambda do |name|
        class_name = "#{name.to_s.camel_case}Service"
        Object.const_get(class_name.to_sym)
      end
    end
  end
  
  it 'should call project save' do
    ProjectRepository.any_instance.expects(:create)

    ProjectsController.new.create(:id => 1, :name => 'Rddd')
  end
end

describe 'NotExistingService' do
  it 'should raise' do
    controller = Object.new
    controller.extend Rddd::Services::ServiceBus

    expect { controller.execute_service(:foo) }.to raise_exception Rddd::Services::ServiceFactory::InvalidService
  end
end