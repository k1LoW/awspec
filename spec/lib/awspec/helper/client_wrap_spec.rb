require 'spec_helper'

# used to test the method_missing functionality #
module RSpec::Mocks
  module Errors
    class RequestLimitExceeded < RuntimeError
    end

    class Throttling < RuntimeError
    end
  end
end

# rubocop:disable Metrics/BlockLength
describe Awspec::Helper::ClientWrap do
  let(:subj) { Awspec::Helper::ClientWrap }

  describe 'wtf .new' do
    let(:client) { subj.new('client') }

    context 'given the correct required arguments' do
      it 'should create a new instance' do
        expect { subj.new("I'm a client") }.to_not raise_error
      end

      it 'should set the client arrtibute' do
        expect(client.client).to eq 'client'
      end

      it 'should set the backoff attribute to the default' do
        expect(client.backoff).to eq 0.0
      end

      it 'should set the iteration attribute to the default' do
        expect(client.iteration).to eq 1
      end

      it 'should set the backoff_limit attribute to the default' do
        expect(client.backoff_limit).to eq 30.0
      end
    end

    context 'given optional args' do
      before(:all) do
        config = Awspec::Config.instance
        config.client_backoff(1.0)
        config.client_backoff_limit(10)
        config.client_iteration(2)
      end

      after(:all) do
        config = Awspec::Config.instance
        config.client_backoff(0.0)
        config.client_backoff_limit(30.0)
        config.client_iteration(1)
      end

      it 'should set the backoff attribute' do
        expect(client.backoff).to eq 1.0
      end

      it 'should set the iteration attribute' do
        expect(client.iteration).to eq 2
      end

      it 'should set the backoff_limit attribute' do
        expect(client.backoff_limit).to eq 10.0
      end
    end

    context 'given no client' do
      it 'should raise an ArgumentError' do
        expect { subj.new }.to raise_error(ArgumentError, 'Client can not be nil')
      end
    end

    context 'given a nil client' do
      it 'should raise an ArgumentError' do
        expect { subj.new(nil) }.to raise_error(ArgumentError, 'Client can not be nil')
      end
    end
  end

  describe '#method_missing (protected)' do
    context 'given the client does not raise ::RequestLimitExceeded error' do
      let(:client) { subj.new({}) }

      it 'should pass the method through to the client' do
        expect(client.empty?).to be true
      end

      it 'should raise exceptions not caught' do
        expect { client.foo }.to raise_error(NoMethodError)
      end
    end

    context 'given the client raises ::RequestLimitExceeded error' do
      let(:client) { double 'fake' }

      before(:all) { Awspec::Config.instance.client_backoff_limit(1) }

      after(:all) { Awspec::Config.instance.client_backoff_limit(30.0) }

      it 'should be called multiple times in a sleep loop, and re-raise the exception if it is not cleared' do
        calls = 0
        allow(client).to receive(:test_me) do
          calls += 1
          raise RSpec::Mocks::Errors::RequestLimitExceeded
        end

        foo = subj.new(client)
        expect { foo.test_me }.to raise_error(RSpec::Mocks::Errors::RequestLimitExceeded)
        expect(foo.backoff).to eq(2.5)
        expect(foo.iteration).to eq(3)
      end

      it 'return as expected once the error is cleared' do
        calls = 0
        res = ''
        allow(client).to receive(:test_me) do
          calls += 1
          raise RSpec::Mocks::Errors::RequestLimitExceeded, 'Fail' if calls == 1

          'done'
        end
        foo = subj.new(client)
        expect { res = foo.test_me }.to_not raise_error
        expect(res).to eq 'done'
      end
    end
    context 'given the client raises ::Throttling error' do
      let(:client) { double 'fake' }

      before(:all) { Awspec::Config.instance.client_backoff_limit(1) }

      after(:all) { Awspec::Config.instance.client_backoff_limit(30.0) }

      it 'should be called multiple times in a sleep loop, and re-raise the exception if it is not cleared' do
        calls = 0
        allow(client).to receive(:test_me) do
          calls += 1
          raise RSpec::Mocks::Errors::Throttling
        end

        foo = subj.new(client)
        expect { foo.test_me }.to raise_error(RSpec::Mocks::Errors::Throttling)
        expect(foo.backoff).to eq(2.5)
        expect(foo.iteration).to eq(3)
      end

      it 'return as expected once the error is cleared' do
        calls = 0
        res = ''
        allow(client).to receive(:test_me) do
          calls += 1
          raise RSpec::Mocks::Errors::Throttling, 'Fail' if calls == 1

          'done'
        end
        foo = subj.new(client)
        expect { res = foo.test_me }.to_not raise_error
        expect(res).to eq 'done'
      end
    end
  end
end
