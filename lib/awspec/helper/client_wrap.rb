require 'awspec/config'

module Awspec::Helper
  class ClientWrap
    attr_reader :client, :backoff, :iteration, :backoff_limit, :symbol1, :symbol2
    def initialize(real_client = nil)
      raise ArgumentError, 'Client can not be nil' if real_client.nil?
      config = Awspec::Config.instance
      @client        = real_client
      @backoff       = config[:client_backoff]
      @orig_backoff  = @backoff
      @iteration     = config[:client_iteration]
      @orig_iter     = @iteration
      @backoff_limit = config[:client_backoff_limit]
      # build the symbol we'll use to compare to any errors caught in method_missing
      # below.
      @symbol1 = real_client.class.to_s.split('::').shift(2).push('Errors', 'RequestLimitExceeded').join('::').to_sym
      @symbol2 = real_client.class.to_s.split('::').shift(2).push('Errors', 'Throttling').join('::').to_sym
    end

    protected

    # used to capture only the "RequestLimitExceeded" error from an aws
    # client api call.  In the case of matching it we want to try again,
    # backing off successively each time, until the backoff_limit is reached or
    # exceeded, in which case, the error will be re-raised and it should fail
    # as expected.
    def method_missing(m, *args, &block)
      begin
        results = client.send(m, *args, &block)
      rescue Exception => e # rubocop:disable Lint/RescueException
        raise unless (e.class.to_s == symbol1.to_s || e.class.to_s == symbol2.to_s) && backoff < backoff_limit

        @backoff = backoff + (iteration * iteration * 0.5)
        @iteration += 1
        sleep backoff
        results = self.send(m, *args, &block)
      end

      reset_backoff

      results
    end

    def reset_backoff
      @backoff   = @orig_backoff
      @iteration = @orig_iter
    end
  end
end
