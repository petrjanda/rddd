require 'spec_helper'
require 'rddd/views/view'
require 'rddd/repository'

class ViewRepository < Rddd::Repository
  def get(id)
  end

  def set(id, value, timeout)
  end
end

describe Rddd::Views::View do
  let(:id) { :id }

  let(:view) { Rddd::Views::View.new(id) }

  let(:view_repository) { stub('view_repository') }

  let(:data) { stub('data') }

  subject { view }

  describe '#initialize' do
    its(:id) { should == id}
  end

  describe '#name' do
    its(:name) { should == :'rddd::views::view' }
  end

  describe '#build' do
    subject { view.build }

    it { lambda {subject}.should raise_exception NotImplementedError }
  end

  describe '#warm_cache' do
    subject { view.warm_cache }

    before do
      ViewRepository.expects(:new).returns(view_repository)

      view.expects(:build).returns(data)

      view_repository.expects(:set).with("rddd::views::#{:view}#{:id}", data, anything)
    end

    it { subject }
  end

  describe '#invalidate' do
    subject { view.invalidate }

    before do
      ViewRepository.expects(:new).returns(view_repository)

      view_repository.expects(:set).with("rddd::views::#{:view}#{:id}", nil)
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
        ViewRepository.expects(:new).returns(view_repository)
      end

      before do
        view_repository.expects(:get).with("rddd::views::#{:view}#{:id}").returns(nil)

        view.expects(:build).returns(data)

        view_repository.expects(:set).with("rddd::views::#{:view}#{:id}", data, nil)
      end

      it { subject.should == data }
    end

    context 'cached' do
      before do
        ViewRepository.expects(:new).returns(view_repository)
        view_repository.expects(:get).with("rddd::views::#{:view}#{:id}").returns(data)
      end

      it { subject.should == data }
    end
  end

  describe 'cache disabling' do
    class CacheLessView < Rddd::Views::View
      cache :enabled => false

      def build
      end
    end

    let(:id) { stub('id') }

    let(:cache_less_view) do
      CacheLessView.new(id)
    end

    it 'should not try to load data from cache' do
      ViewRepository.expects(:new).never

      cache_less_view.expects(:build).returns(data)

      cache_less_view.data.should == data
    end
  end

  describe 'timeout enabling' do
    class TimeoutingView < Rddd::Views::View
      cache :timeout => 24 * 60

      def build
      end
    end

    let(:id) { :id }

    let(:timeouting_view) do
      TimeoutingView.new(id)
    end

    it 'should set timeout to cache data' do
      ViewRepository.expects(:new).returns(view_repository)
      view_repository.expects(:get).with("#{:timeoutingview}#{:id}").returns(nil)

      timeouting_view.expects(:build).returns(data)

      view_repository.expects(:set).with do |got_id, got_data, got_time|
        got_id == "#{:timeoutingview}#{:id}" &&
        got_data == data &&
        got_time.to_i == (Time.now + 24 * 60 * 60).to_i
      end

      timeouting_view.data
    end
  end
end