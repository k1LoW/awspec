module Awspec::Helper
  class ClientWrap
    attr_reader :client, :backoff, :iteration, :backoff_limit, :symbol
    def initialize(real_client = nil, args = {})
      raise ArgumentError, 'Client can not be nil' if real_client.nil?
      @client        = real_client
      @backoff       = args.key?(:backoff) ? args[:backoff] : 0.0
      @orig_backoff  = @backoff
      @iteration     = args.key?(:iteration) ? args[:iteration] : 1
      @orig_iter     = @iteration
      @backoff_limit = args.key?(:backoff_limit) ? args[:backoff_limit] : 30.0
      # build the symbol we'll use to compare to any errors caught in method_missing
      # below.
      @symbol = real_client.class.to_s.split('::').shift(2).push('Errors', 'RequestLimitExceeded').join('::').to_sym
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
        raise unless e.class.to_s == symbol.to_s && backoff < backoff_limit

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
