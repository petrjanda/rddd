require 'spec_helper'
require 'rddd/services/remote_service'

module Rddd
  module Services
    describe RemoteService do
      let(:attributes) { {:foo => 'bar'} }

      let(:endpoint) { 'http://remote.dev/' }

      let(:namespace) { 'namespace' }

      let(:service_name) { :service_name }

      before do
        Configuration.instance.remote_services = [
          {:namespace => namespace, :endpoint => endpoint}
        ]
      end

      describe '#valid?' do
        subject { RemoteService.build(namespace, service_name).valid? }

        it { should be_true }
      end

      describe '#execute' do
        subject { RemoteService.build(namespace, service_name, attributes).execute }

        let(:result) { {"foo" => "bar"} }

        let(:transport) { stub('transport') }

        it 'should raise not implemented' do
          Transports::HttpJson.expects(:new).with(:endpoint => endpoint).returns(transport)
          transport.expects(:call).with(service_name, attributes).returns(result)
          
          subject.should == result
        end
      end
    end
  end
end