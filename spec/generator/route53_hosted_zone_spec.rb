require 'spec_helper'

# rubocop:disable all
describe 'Awspec::Generator::Spec::Route53HostedZone' do
  before do
    require 'stub/route53_hosted_zone'
  end
  let(:route53_hosted_zone) { Awspec::Generator::Spec::Route53HostedZone.new }
  it 'generate_by_domain_name generate spec' do
    spec = <<-'EOF'
describe route53_hosted_zone('example.com.') do
  it { should exist }
  its(:resource_record_set_count) { should eq 5 }
  it { should have_record_set('example.com.').a('123.456.7.890').ttl(3600) }
  it { should have_record_set('example.com.').mx('10 mail.example.com').ttl(3600) }
  it { should have_record_set('mail.example.com.').a('123.456.7.890').ttl(3600) }
  it { should have_record_set('example.com.').ns('ns-123.awsdns-45.net.
ns-6789.awsdns-01.org.
ns-2345.awsdns-67.co.uk.
ns-890.awsdns-12.com.').ttl(172800) }
  it { should have_record_set('s3.example.com.').alias('s3-website-us-east-1.amazonaws.com.', 'Z2ABCDEFGHIJKL').ttl(3600) }
end
EOF
    expect(route53_hosted_zone.generate_by_domain_name('example.com.').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
