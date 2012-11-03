require 'spec_helper'
require 'rddd/service_factory'

describe ServiceFactory do
  let(:attributes) { stub('attributes') }

  before { Object.const_set(:FooService, Class.new) }

  after { Object.class_eval {remove_const(:FooService)} }

  describe '.build' do
    it do
      FooService.expects(:new).with(attributes)

      ServiceFactory.build(:foo, attributes)
    end
  end
end