require 'awspec/error'

module Awspec
  class Config
    def initialize
      @config = {}
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

    def method_missing(method_name, *args)
      raise UnknownConfiguration.new("'#{method_name}' is not a valid configuration for Awspec.")
    end
  end
end