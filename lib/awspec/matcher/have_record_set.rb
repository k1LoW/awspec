RSpec::Matchers.define :have_record_set do |name|
  match do |hosted_zone|
    hosted_zone.has_record_set?(name, @type, @value, @options)
  end

  %w(soa a txt ns cname mx ptr srv spf aaaa caa).each do |type|
    chain type do |value|
      @type = type
      @value = value
      @options = {} if @options.nil?
    end
  end

  chain :alias do |dns_name, hosted_zone_id|
    @type = 'a'
    @options = {} if @options.nil?
    @options[:alias_dns_name] = dns_name
    @options[:alias_hosted_zone_id] = hosted_zone_id
  end

  chain :aaaa_alias do |dns_name, hosted_zone_id|
    @type = 'aaaa'
    @options = {} if @options.nil?
    @options[:alias_dns_name] = dns_name
    @options[:alias_hosted_zone_id] = hosted_zone_id
  end

  chain :ttl do |ttl|
    @options = {} if @options.nil?
    @options[:ttl] = ttl
  end

  chain :type do |type|
    @type = type
  end

  chain :failover do |record_type|
    @options = {} if @options.nil?
    @options[:record_type] = record_type
  end
end
