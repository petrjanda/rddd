require 'spec_helper'
require 'rddd/services/service_factory'

module Rddd
  module Services
    describe ServiceFactory do
      let(:attributes) { stub('attributes') }

      let(:service_creator) do
        lambda do |name|
          class_name = "#{name.to_s.camel_case}Service"
          Services.const_get(class_name.to_sym)
        end
      end

      before do
        Services.const_set(:CreateProjectService, Class.new)
      end

      after do
        Services.class_eval {remove_const(:CreateProjectService)}
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
            CreateProjectService.expects(:new).with(attributes)

            ServiceFactory.build(:create_project, attributes)
          end
        end

        context 'not existing service' do
          before do
            Rddd.configure { |config| config.service_creator = service_creator }
          end

          after do
            Rddd.configure { |config| config.service_creator = nil }
          end

          it { expect { ServiceFactory.build(:foo, attributes) }.to raise_exception ServiceFactory::InvalidService }
        end

        context 'configuration service_creator not given' do
          it 'should raise exception' do
            expect { Rddd::Services::ServiceFactory.build(:create_project, attributes) }.to raise_exception Rddd::Services::ServiceFactory::StrategyNotGiven
          end
        end
      end
    end
  end
end