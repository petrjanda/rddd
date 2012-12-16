require 'spec_helper'
require 'rddd/authorization/rules_builder'

describe Rddd::Authorization::RulesBuilder do
  let(:builder) do
    Object.new.tap do |object|
      object.extend Rddd::Authorization::RulesBuilder
    end
  end

  describe '#rules' do
    subject { builder.rules }

    let(:rule) { stub('rule') }

    let(:action) { :foo }

    let(:block) { lambda{|user, params| } }

    before do
      Rddd::Authorization::Rule.expects(:new).returns(rule)

      builder.can(:foo, &block)
    end

    its(:first) { should be rule }
  end

end