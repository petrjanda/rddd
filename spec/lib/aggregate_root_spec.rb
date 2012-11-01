require 'spec_helper'
require 'rddd/aggregate_root'

describe AggregateRoot do
  let(:entity) do
    stub('entity').tap {|entity| entity.extend AggregateRoot }
  end

  [:create, :update, :delete].each do |action|
    describe "##{action}" do
      subject { entity.send(action) }

      let(:repository) { stub('repository') }

      it 'should call #create on repository' do
        RepositoryFactory.expects(:build).returns(repository)

        repository.expects(action).with(subject)
        
        subject
      end
    end
  end
end