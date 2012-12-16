require 'spec_helper'
require 'rddd/authorization/authorize'

describe Rddd::Authorization::Authorize do
  let(:authorize) do
    Rddd::Authorization::Authorize.new(
      rules, user
    )
  end

  describe '#can?' do
    subject { authorize.can?(action, params) }

    let(:rule) { stub('rule') }
    let(:rules) { [rule] }

    let(:user) { stub('user') }

    let(:params) { {:foo => 'bar'} }

    let(:action) { :foo }

    context 'has no rule' do
      let(:rules) { [] }

      it { should be_true }
    end

    context 'has aplicable rule which is positive' do
      before do
        rule.expects(:is_for?).with(:foo).returns(true)
        rule.expects(:can?).with(user, params).returns(true)
      end

      it { should be_true }
    end

    context 'has applicable rule which is negative' do
      before do
        rule.expects(:is_for?).with(:foo).returns(true)
        rule.expects(:can?).with(user, params).returns(false)
      end

      it { should be_false }
    end

    context 'has no applicable rule' do
      before do
        rule.expects(:is_for?).with(:foo).returns(false)
      end

      it { should be_true }    
    end
  end
end