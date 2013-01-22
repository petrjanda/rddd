require 'spec_helper'
require 'rddd/services/transports/http_json'

module Rddd
  module Services
    module Transports
      describe HttpJson do
        let(:transport_attributes) do
          {
            :endpoint => 'http://remote.dev/'
          }
        end

        let(:transport) { HttpJson.new(transport_attributes) }

        describe '#call' do
          subject { transport.call(service_name, attributes) }

          let(:service_name) { :service_name }

          let(:attributes) { {'foo' => 'bar'} }

          let(:body) { {'foo' => 'bar'} }

          let(:client) { stub('client') }

          let(:result) { stub('result', :body => JSON.unparse(body)) }

          before do
            HTTPClient.expects(:new).returns(client)
            client.expects(:post) \
            .with('http://remote.dev/service_name', :body => JSON.unparse(attributes), :header => {'Content-Type' => 'application/json'}) \
            .returns(result)
          end


          it { should == body }
        end
      end
    end
  end
end