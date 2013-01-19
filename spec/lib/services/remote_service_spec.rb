require 'spec_helper'
require 'rddd/services/remote_service'

module Rddd
  module Services
    describe RemoteService do
      let(:attributes) { {:foo => 'bar'} }

      let(:url) { 'http://remote.dev/' }

      describe '#initialize' do
        subject { RemoteService.new(url, attributes) }

        it 'should store attributes' do
          subject.instance_variable_get(:@attributes).should == attributes
        end
      end  

      describe '#valid?' do
        subject { RemoteService.new(url).valid? }

        it { should be_true }
      end

      describe '#execute' do
        subject { RemoteService.new(url, attributes).execute }

        let(:curl) { stub('curl', :body_str => '{"foo": "bar"}', :headers => [])}

        it 'should raise not implemented' do
          Curl.expects(:post).with(url, JSON.unparse(attributes)).yields(curl).returns(curl)
          curl.headers.expects(:[]=).with('Content-Type', 'application/json')

          subject.should == {'foo' => 'bar'}
        end
      end
    end
  end
end