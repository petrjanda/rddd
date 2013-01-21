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

          let(:result) { {'foo' => 'bar'} }

          let(:curl) { stub('curl', :body_str => '{"foo": "bar"}', :headers => [])}

          before do
            Curl.expects(:post) \
            .with('http://remote.dev/service_name', JSON.unparse(attributes)) \
            .yields(curl) \
            .returns(curl)

            curl.headers.expects(:[]=).with('Content-Type', 'application/json')
          end


          it { should == result }
        end
      end
    end
  end
end