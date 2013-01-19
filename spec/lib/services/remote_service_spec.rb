require 'spec_helper'
require 'rddd/services/remote_service'

module Rddd
  module Services
    describe RemoteService do
      let(:attributes) { stub('attributes') }

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

        let(:curl) { stub('curl', :body_str => 'foo')}

        it 'should raise not implemented' do
          Curl.expects(:post).with(url, attributes).returns(curl)

          subject.should == 'foo'
        end
      end
    end
  end
end