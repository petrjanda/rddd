require 'spec_helper'
require 'rddd/service'

describe Service do
  let(:attributes) { stub('attributes') }

  describe '#initialize' do
    subject { Service.new(attributes) }

    it 'should store attributes' do
      subject.instance_variable_get(:@attributes).should == attributes
    end
  end  

  describe '#execute' do
    it 'should raise not implemented' do
      lambda do
        Service.new(attributes).execute
      end.should raise_exception(NotImplementedError)
    end
  end
end