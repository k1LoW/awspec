RSpec::Matchers.define :have_origin do |origin_id|
  match do |cloudfront_distribution|
    cloudfront_distribution.has_origin?(origin_id,
                                        domain_name: @domain_name,
                                        origin_path: @origin_path,
                                        origin_access_identity: @origin_access_identity
                                       )
  end

  chain :domain_name do |domain_name|
    @domain_name = domain_name
  end

  chain :origin_path do |origin_path|
    @origin_path = origin_path
  end

  chain :origin_access_identity do |origin_access_identity|
    @origin_access_identity = origin_access_identity
  end
end
