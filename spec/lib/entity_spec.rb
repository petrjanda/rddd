require 'spec_helper'
require 'rddd/entity'

describe Entity do
  it 'should have identity' do
    entity = Entity.new('1234')

    entity.id.should == '1234'
  end

  it 'two entities with same identity are equal' do
    a = Entity.new('1234')
    b = Entity.new('1234')

    (a == b).should be_true
  end
end