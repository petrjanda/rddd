require 'spec_helper'
require 'rddd/service_bus'

describe Rddd::ServiceBus do
  let(:attributes) { stub('attributes') }

  let(:controller) do
    stub('controller').tap { |controller| controller.extend Rddd::ServiceBus }
  end

  describe '.execute' do
    subject { controller.execute(:foo, attributes) }

    let(:service) { stub('service', :valid? => true, :execute => nil) }

    context 'existing service' do
      it do
        Rddd::ServiceFactory.expects(:build).with(:foo, attributes).returns(service)
        service.expects(:execute)

        subject
      end
    end

    context 'not-existing service' do
      it do
        Rddd::ServiceFactory.expects(:build).with(:foo, attributes).returns(nil)
        service.expects(:execute).never

        lambda { subject }.should raise_exception Rddd::InvalidService
      end
    end

    context 'not valid call to service' do
      context 'without block' do
        before { service.stubs(:valid?).returns(false) }

        it do
          Rddd::ServiceFactory.expects(:build).with(:foo, attributes).returns(service)
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
          Rddd::ServiceFactory.expects(:build).with(:foo, attributes).returns(service)
          service.expects(:execute).never

          controller.execute(:foo, attributes, &error_block)
        end
      end
    end
  end
end