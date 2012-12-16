require 'spec_helper'
require 'rddd/authorization/authorize'
require 'rddd/authorization/rules_builder'

describe Rddd::Authorization::Authorize do
  let(:builder) do
    Object.new.tap do |object|
      object.extend Rddd::Authorization::RulesBuilder

      object.can :create_project do |user, params|
        user.owner? && user.account_id == params[:account_id]
      end
    end
  end

  describe 'create_project' do
    subject do 
      Rddd::Authorization::Authorize.new(builder.rules, user) \
      .can?(:create_project, {:account_id => '1'})
    end

    context 'user is owner' do
      let(:user) do
        stub('user',
          :owner? => true,
          :account_id => '1'
        )
      end

      it { should be_true }
    end

    context 'user is not owner' do
      let(:user) do
        stub('user',
          :owner? => false,
          :account_id => '1'
        )
      end

      it { should be_false }
    end

    context 'user is not on same account' do
      let(:user) do
        stub('user',
          :owner? => true,
          :account_id => '2'
        )
      end

      it { should be_false }
    end
  end
end