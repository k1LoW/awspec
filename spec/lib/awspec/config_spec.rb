require 'spec_helper'

describe Awspec::Config do
  context 'given the Config object' do
    let(:subject) { Awspec::Config.instance }

    it 'should have the default configurations for an awspec client' do
      expect(subject[:client_backoff]).to be(0.0)
      expect(subject[:client_backoff_limit]).to be(30.0)
      expect(subject[:client_iteration]).to be(1)
    end

    it 'should save configuration data' do
      subject.client_backoff(60)
      subject.client_iteration(4)
      subject.client_backoff_limit(10)

      expect(subject[:client_backoff]).to be(60)
      expect(subject[:client_backoff_limit]).to be(10)
      expect(subject[:client_iteration]).to be(4)
    end

    it 'should throw a KeyError if config not set' do
      expect { subject[:not_set_config] }.to raise_error(KeyError)
    end

    it 'should handle incorrect configuration with better error message' do
      expect { subject.greeting('hello') }.to raise_error(
        Awspec::UnknownConfiguration,
        "'greeting' is not a valid configuration for Awspec."
      )
    end
  end
end
