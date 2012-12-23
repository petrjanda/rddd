require 'spec_helper'
require 'rddd/aggregate_root'

describe Rddd::AggregateRoot do
  let(:id) { stub('id') }
  
  let(:aggregate_root) { Rddd::AggregateRoot.new(id) }

  it 'should be entity' do
    aggregate_root.should be_kind_of Rddd::Entity
  end

  describe '#find' do
    subject { Rddd::AggregateRoot.find(id) }

    let(:repository) { stub('repository') }

    before {
      Rddd::Repositories::RepositoryFactory.expects(:build).returns(repository)
      repository.expects(:find).with(id) 
    }

    it { subject }
  end

  [:create, :update, :delete].each do |action|
    describe "##{action}" do
      subject { aggregate_root.send(action) }

      let(:repository) { stub('repository') }

      it 'should call #create on repository' do
        Rddd::Repositories::RepositoryFactory.expects(:build).with(Rddd::AggregateRoot).returns(repository)

        repository.expects(action).with(subject)
        
        subject
      end
    end
  end
end