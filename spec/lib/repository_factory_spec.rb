require 'spec_helper'
require 'rddd/repositories/repository_factory'

describe Rddd::RepositoryFactory do
  let(:project) { stub('project', :name => 'Foo', :class => stub(:name => 'Foo')) }

  let(:repository_creator) do
    lambda do |clazz|
      class_name = "#{clazz.name.to_s.camel_case}Repository"
      Rddd::Repositories.const_get(class_name.to_sym)
    end
  end

  before do
    Rddd::Repositories.const_set(:FooRepository, Class.new)
  end

  after do
    Rddd::Repositories.class_eval { remove_const(:FooRepository) }
  end

  describe '.build' do
    context 'configuration repository_creator given' do
      before do
        Rddd.configure { |config| config.repository_creator = repository_creator }
      end

      after do
        Rddd.configure { |config| config.repository_creator = nil }
      end

      it 'should call the appropriate service' do
        Rddd::Repositories::FooRepository.expects(:new)

        Rddd::RepositoryFactory.build(project.class)
      end
    end

    context 'configuration repository_creator not given' do
      it 'should raise exception' do
        expect { Rddd::RepositoryFactory.build(project.class) }.to raise_exception Rddd::RepositoryFactory::CreatorNotGiven
      end
    end
  end
end