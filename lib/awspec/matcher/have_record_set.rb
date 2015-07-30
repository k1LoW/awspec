RSpec::Matchers.define :have_record_set do |name|
  match do |hosted_zone|
    hosted_zone.has_record_set?(name, @type, @value)
  end

  %w(soa a txt ns cname mx ptr srv spf aaaa).each do |type|
    chain type do |value|
      @type = type
      @value = value
    end
  end

  chain :ttl do |ttl|
    @ttl = ttl
  end
end
