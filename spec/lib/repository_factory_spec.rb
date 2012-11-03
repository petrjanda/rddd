require 'spec_helper'
require 'rddd/entity'
require 'rddd/repository_factory'

describe Rddd::RepositoryFactory do
  describe '.build' do
    subject { Rddd::RepositoryFactory.build(Rddd::Entity) }

    context 'with existing repository' do
      before do
        Rddd.const_set(:Repositories, Module.new)
        Rddd::Repositories.const_set(:EntityRepository, Class.new)

        Rddd.configure { |config| config.repositories_namespace = Rddd::Repositories }
      end
      
      after do
        Rddd::Repositories.class_eval {remove_const(:EntityRepository)}
        Rddd.class_eval {remove_const(:Repositories)}

        Rddd.configure { |config| config.repositories_namespace = Object }
      end

      it 'should return instance of repository' do
        should be_kind_of Rddd::Repositories::EntityRepository
      end
    end

    context 'with not existing repository' do
      it 'should raise NotExistingRepository' do
        lambda { subject }.should raise_exception Rddd::NotExistingRepository
      end
    end
  end
end