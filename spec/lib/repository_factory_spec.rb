require 'spec_helper'
require 'rddd/entity'
require 'rddd/repository_factory'

describe RepositoryFactory do
  describe '.build' do
    subject { RepositoryFactory.build(Entity) }

    context 'with existing repository' do
      before { Object.const_set(:EntityRepository, Class.new) }

      after { Object.class_eval{remove_const :EntityRepository} }

      it 'should return instance of repository' do
        should be_kind_of EntityRepository
      end
    end

    context 'with not existing repository' do
      it 'should raise NotExistingRepository' do
        lambda { subject }.should raise_exception NotExistingRepository
      end
    end
  end
end