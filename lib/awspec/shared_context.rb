shared_context 'region', :region do
  before do |example|
    region = example.metadata[:region]
    @_region = Aws.config[:region]
    Aws.config[:region] = region
  end

  after do
    Aws.config[:region] = @_region
  end
end

shared_context 'cluster_name', :cluster_name do
  before do |example|
    cluster_name = example.metadata[:cluster_name]
    example.metadata[:described_class].cluster_name = cluster_name
  end

  after do
  end
end
