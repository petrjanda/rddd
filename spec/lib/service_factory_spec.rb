require 'spec_helper'
require 'rddd/service_factory'

describe ServiceFactory do
  let(:attributes) { stub('attributes') }

  before { Object.const_set(:CreateProjectService, Class.new) }

  after { Object.class_eval {remove_const(:CreateProjectService)} }

  describe '.build' do
    it do
      CreateProjectService.expects(:new).with(attributes)

      ServiceFactory.build(:create_project, attributes)
    end
  end
end