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

shared_context 'cluster', :cluster do
  before do |example|
    example.metadata[:described_class].cluster = example.metadata[:cluster]
  end
end
