require 'singleton'

require 'awspec/error'

module Awspec
  class Config
    include Singleton

    def initialize
      @config = {
        client_backoff: 0.0,
        client_backoff_limit: 30.0,
        client_iteration: 1
      }
    end

    def client_backoff(backoff)
      @config[:client_backoff] = backoff
    end

    def client_backoff_limit(backoff_limit)
      @config[:client_backoff_limit] = backoff_limit
    end

    def client_iteration(iteration)
      @config[:client_iteration] = iteration
    end

    def [](key)
      @config.fetch(key)
    end

    def method_missing(method_name, *_args)
      raise UnknownConfiguration, "'#{method_name}' is not a valid configuration for Awspec."
    end
  end

  def self.configure
    yield(Config.instance)
  end
end
