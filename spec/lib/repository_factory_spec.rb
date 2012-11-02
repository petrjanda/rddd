require 'spec_helper'
require 'rddd/repository_factory'

describe RepositoryFactory do
  describe '.build' do
    subject { RepositoryFactory.build }

    let(:driver) { stub('driver') }

    context 'with driver' do
      before { RepositoryFactory.driver = driver }

      after { RepositoryFactory.driver = nil }

      it 'should return instance of repository' do
        should be_kind_of Repository
      end
    end

    context 'without driver' do
      it 'should raise NoDriverException' do
        lambda { subject }.should raise_exception NoDatabaseDriver
      end
    end
  end
end