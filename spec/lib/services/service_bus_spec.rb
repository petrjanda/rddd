require 'spec_helper'
require 'rddd/services/service_bus'

describe Rddd::Services::ServiceBus do
  let(:attributes) { stub('attributes') }

  let(:controller) do
    stub('controller').tap { |controller| controller.extend Rddd::Services::ServiceBus }
  end

  describe '.execute_service' do
    subject { controller.execute_service(:foo, attributes) }

    let(:service) { stub('service', :valid? => true, :execute => nil) }

    context 'existing service' do
      it do
        Rddd::Services::ServiceFactory.expects(:build).with(:foo, attributes).returns(service)
        service.expects(:execute)

        subject
      end
    end

    context 'not valid call to service' do
      context 'without block' do
        before { service.stubs(:valid?).returns(false) }

        it do
          Rddd::Services::ServiceFactory.expects(:build).with(:foo, attributes).returns(service)
          service.expects(:execute).never

          subject
        end
      end

      context 'with error callback block' do
        let(:errors) { stub('errors') }

        before do
          service.stubs(:valid?).returns(false)
          service.stubs(:errors).returns(errors)
        end

        let(:error_block) { lambda {|errors|} }

        it do
          Rddd::Services::ServiceFactory.expects(:build).with(:foo, attributes).returns(service)
          service.expects(:execute).never

          controller.execute_service(:foo, attributes, &error_block)
        end
      end
    end
  end
end