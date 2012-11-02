require 'spec_helper'
require 'rddd/aggregate_root'

describe AggregateRoot do
  let(:aggregate_root) { AggregateRoot.new }

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