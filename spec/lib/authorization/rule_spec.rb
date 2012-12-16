require 'spec_helper'
require 'rddd/authorization/rule'

describe Rddd::Authorization::Rule do

  let(:action) { :foo }

  let(:block) { lambda { |user, params| true } }

  let(:authorize) do
    Rddd::Authorization::Rule.new(
      action, &block
    )
  end

  describe 'should raise if rule block is invalid' do
    let(:block) { lambda { |user| true } }

    it { expect { authorize }.to raise_exception Rddd::Authorization::Rule::InvalidEvaluationBlock }
  end

  describe '#is_for?' do
    subject { authorize.is_for?(questioned_action) }

    context 'matching action' do
      let(:questioned_action) { :foo }

      it { should be_true }
    end

    context 'not matching action' do
      let(:questioned_action) { :bar }
      
      it { should be_false }
    end
  end

  describe '#can?' do
    let(:user) { stub('user, params') }

    let(:params) { stub('user, params') }

    subject { authorize.can?(user, params) }

    describe 'passing right params to block' do
      before do
        block.expects(:call).with(user, params).returns(false)
      end

      it { should be_false }
    end

    it 'should return true as lambda does' do
      should be_true
    end
  end
end