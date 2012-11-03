require 'spec_helper'
require 'rddd/aggregate_root'

describe AggregateRoot do
  let(:id) { stub('id') }
  
  let(:aggregate_root) { AggregateRoot.new(id) }

  it 'should be entity' do
    aggregate_root.should be_kind_of Entity
  end

  describe '#find_by_id' do
    subject { AggregateRoot.find_by_id(id) }

    let(:repository) { stub('repository') }

    before {
      RepositoryFactory.expects(:build).returns(repository)
      repository.expects(:find_by_id).with(id) 
    }

    it { subject }
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