require 'spec_helper'
require 'rddd/services/service'

module Rddd
  module Services
    describe Service do
      let(:attributes) { stub('attributes') }

      describe '#initialize' do
        subject { Service.new(attributes) }

        it 'should store attributes' do
          subject.instance_variable_get(:@attributes).should == attributes
        end
      end  

      describe '#valid?' do
        subject { Service.new.valid? }
        it { should be_true }
      end

      describe '#execute' do
        it 'should raise not implemented' do
          lambda do
            Service.new(attributes).execute
          end.should raise_exception(NotImplementedError)
        end
      end
    end
  end
end