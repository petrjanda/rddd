require 'spec_helper'
require 'rddd/service'

describe Rddd::Service do
  let(:attributes) { stub('attributes') }

  describe '#initialize' do
    subject { Rddd::Service.new(attributes) }

    it 'should store attributes' do
      subject.instance_variable_get(:@attributes).should == attributes
    end
  end  

  describe '#valid?' do
    subject { Rddd::Service.new.valid? }
    it { should be_true }
  end

  describe '#execute' do
    it 'should raise not implemented' do
      lambda do
        Rddd::Service.new(attributes).execute
      end.should raise_exception(NotImplementedError)
    end
  end
end