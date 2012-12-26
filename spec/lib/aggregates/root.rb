require 'spec_helper'
require 'rddd/aggregates/root'

describe Rddd::Aggregates::Root do
  let(:id) { stub('id') }
  
  let(:aggregate_root) { Rddd::Aggregates::Root.new(id) }

  it 'should be entity' do
    aggregate_root.should be_kind_of Rddd::Aggregates::Entity
  end

  describe '#find' do
    subject { Rddd::Aggregates::Root.find(id) }

    let(:repository) { stub('repository') }

    before {
      Rddd::Repositories::Factory.expects(:build).returns(repository)
      repository.expects(:find).with(id) 
    }

    it { subject }
  end

  [:create, :update, :delete].each do |action|
    describe "##{action}" do
      subject { aggregate_root.send(action) }

      let(:repository) { stub('repository') }

      it 'should call #create on repository' do
        Rddd::Repositories::Factory.expects(:build).with(Rddd::Aggregates::Root).returns(repository)

        repository.expects(action).with(subject)
        
        subject
      end
    end
  end
end