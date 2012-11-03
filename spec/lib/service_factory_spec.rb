require 'spec_helper'
require 'rddd/service_factory'

describe ServiceFactory do
  let(:attributes) { stub('attributes') }

  before do
    Rddd.const_set(:Services, Module.new)
    Rddd::Services.const_set(:CreateProjectService, Class.new)

    Rddd.configure { |config| config.services_namespace = Rddd::Services }
  end

  after do
    Rddd::Services.class_eval {remove_const(:CreateProjectService)}
    Rddd.class_eval {remove_const(:Services)}
    
    Rddd.configure { |config| config.services_namespace = Object }
  end

  describe '.build' do
    it do
      Rddd::Services::CreateProjectService.expects(:new).with(attributes)

      ServiceFactory.build(:create_project, attributes)
    end
  end
end