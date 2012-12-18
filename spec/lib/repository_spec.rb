require 'spec_helper'
require 'rddd/repository'

describe Rddd::Repository do
  let(:repository) { Rddd::Repository.new }

  let(:aggregate_root) { stub('aggregate_root') }

  describe '#create' do
    subject { repository.create(aggregate_root) }

    it { expect { subject }.to raise_exception NotImplementedError }
  end

  describe '#update' do
    subject { repository.update(aggregate_root) }

    it { expect { subject }.to raise_exception NotImplementedError }
  end

  describe '#delete' do
    subject { repository.delete(aggregate_root) }

    it { expect { subject }.to raise_exception NotImplementedError }
  end
end