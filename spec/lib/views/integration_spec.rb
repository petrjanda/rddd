require 'spec_helper'
require 'rddd/views/view'
require 'rddd/aggregates/repositories/base'

class NilStrategy
  def get(id)
    nil
  end

  def set(id, value, timeout)
    value
  end
end

describe Rddd::Views::View do
  before do
    Rddd.configure do |config|
      config.caching_strategy = NilStrategy
    end
  end

  let(:id) { :id }

  let(:view) { Rddd::Views::View.new(id).tap {|view| view.extend Rddd::Views::Cacheable } }

  let(:nil_strategy) { stub('nil_strategy') }

  let(:data) { stub('data') }

  subject { view }

  describe '#initialize' do
    its(:id) { should == id}
  end

  describe '#data' do
    subject { view.data }

    it { lambda {subject}.should raise_exception NotImplementedError }
  end

  describe '#warm_up' do
    subject { view.warm_up }

    before do
      NilStrategy.expects(:new).returns(nil_strategy)

      view.expects(:build).returns(data)

      nil_strategy.expects(:set).with("rddd::views::#{:view}#{:id}", data, anything)
    end

    it { subject }
  end

  describe '#invalidate' do
    subject { view.invalidate }

    before do
      NilStrategy.expects(:new).returns(nil_strategy)

      nil_strategy.expects(:set).with("rddd::views::#{:view}#{:id}", nil, nil)
    end

    it { subject }
  end

  describe '#data' do
    subject { view.data }

    context 'without view repository' do
      before do
        view.expects(:build).returns(data)
      end

      it { subject.should == data }
    end

    context 'not cached' do
      before do
        NilStrategy.expects(:new).returns(nil_strategy)
      end

      before do
        nil_strategy.expects(:get).with("rddd::views::#{:view}#{:id}").returns(nil)

        view.expects(:build).returns(data)

        nil_strategy.expects(:set).with("rddd::views::#{:view}#{:id}", data, nil)
      end

      it { subject.should == data }
    end

    context 'cached' do
      before do
        NilStrategy.expects(:new).returns(nil_strategy)
        nil_strategy.expects(:get).with("rddd::views::#{:view}#{:id}").returns(data)
      end

      it { subject.should == data }
    end
  end

  describe 'view without cache' do
    class CacheLessView < Rddd::Views::View
      def build
      end
    end

    let(:id) { stub('id') }

    let(:cache_less_view) do
      CacheLessView.new(id)
    end

    it 'should not try to load data from cache' do
      NilStrategy.expects(:new).never

      cache_less_view.expects(:build).returns(data)

      cache_less_view.data.should == data
    end
  end

  describe 'timeout enabling' do
    class TimeoutingView < Rddd::Views::View
      include Rddd::Views::Cacheable

      cache :timeout => 24 * 60

      def build
      end
    end

    let(:id) { :id }

    let(:timeouting_view) do
      TimeoutingView.new(id)
    end

    it 'should set timeout to cache data' do
      NilStrategy.expects(:new).returns(nil_strategy)
      nil_strategy.expects(:get).with("#{:timeoutingview}#{:id}").returns(nil)

      timeouting_view.expects(:build).returns(data)

      nil_strategy.expects(:set).with do |got_id, got_data, got_time|
        got_id == "#{:timeoutingview}#{:id}" &&
        got_data == data &&
        got_time.to_i == (Time.now + 24 * 60 * 60).to_i
      end

      timeouting_view.data
    end
  end
end