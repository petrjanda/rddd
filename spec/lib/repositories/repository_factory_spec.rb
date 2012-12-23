require 'spec_helper'
require 'rddd/repositories/repository_factory'

module Rddd
  module Repositories
    describe RepositoryFactory do
      let(:project) { stub('project', :name => 'Foo', :class => stub(:name => 'Foo')) }

      let(:repository_creator) do
        lambda do |clazz|
          class_name = "#{clazz.name.to_s.camel_case}Repository"
          Repositories.const_get(class_name.to_sym)
        end
      end

      before do
        Repositories.const_set(:FooRepository, Class.new)
      end

      after do
        Repositories.class_eval { remove_const(:FooRepository) }
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
            FooRepository.expects(:new)

            RepositoryFactory.build(project.class)
          end
        end

        context 'configuration repository_creator not given' do
          it 'should raise exception' do
            expect { RepositoryFactory.build(project.class) }.to raise_exception RepositoryFactory::CreatorNotGiven
          end
        end
      end
    end
  end
end