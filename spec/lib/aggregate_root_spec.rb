require 'spec_helper'
require 'rddd/aggregate_root'

describe AggregateRoot do
  let(:id) { stub('id') }
  
  let(:aggregate_root) { AggregateRoot.new(id) }

  it 'should be entity' do
    aggregate_root.should be_kind_of Entity
  end

  [:create, :update, :delete].each do |action|
    describe "##{action}" do
      subject { aggregate_root.send(action) }

      let(:repository) { stub('repository') }

      it 'should call #create on repository' do
        RepositoryFactory.expects(:build).with(AggregateRoot).returns(repository)

        repository.expects(action).with(subject)
        
        subject
      end
    end
  end
end