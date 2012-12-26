require 'spec_helper'
require 'rddd/aggregates/entity'

describe Rddd::Aggregates::Entity do
  it 'should have identity' do
    entity = Rddd::Aggregates::Entity.new('1234')

    entity.id.should == '1234'
  end

  it 'two entities with same identity are equal' do
    a = Rddd::Aggregates::Entity.new('1234')
    b = Rddd::Aggregates::Entity.new('1234')

    (a == b).should be_true
  end
end