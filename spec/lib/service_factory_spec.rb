require 'spec_helper'
require 'rddd/service_factory'

describe Rddd::ServiceFactory do
  let(:attributes) { stub('attributes') }

  let(:service_creator) do
    lambda do |name|
      class_name = "#{name.to_s.camel_case}Service"
      Rddd::Services.const_get(class_name.to_sym)
    end
  end

  before do
    Rddd.const_set(:Services, Module.new)
    Rddd::Services.const_set(:CreateProjectService, Class.new)
  end

  after do
    Rddd::Services.class_eval {remove_const(:CreateProjectService)}
    Rddd.class_eval {remove_const(:Services)}
  end

  describe '.build' do
    context 'configuration service_creator given' do
      before do
        Rddd.configure { |config| config.service_creator = service_creator }
      end

      after do
        Rddd.configure { |config| config.service_creator = nil }
      end

      it 'should call the appropriate service' do
        Rddd::Services::CreateProjectService.expects(:new).with(attributes)

        Rddd::ServiceFactory.build(:create_project, attributes)
      end
    end

    context 'not existing service' do
      before do
        Rddd.configure { |config| config.service_creator = service_creator }
      end

      after do
        Rddd.configure { |config| config.service_creator = nil }
      end

      it { expect { Rddd::ServiceFactory.build(:foo, attributes) }.to raise_exception Rddd::ServiceFactory::InvalidService }
    end

    context 'configuration service_creator not given' do
      it 'should raise exception' do
        expect { Rddd::ServiceFactory.build(:create_project, attributes) }.to raise_exception Rddd::ServiceFactory::CreatorNotGiven
      end
    end
  end
end