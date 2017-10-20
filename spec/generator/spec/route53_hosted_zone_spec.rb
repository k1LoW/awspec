require 'spec_helper'

describe 'Awspec::Generator::Spec::Route53HostedZone' do
  before do
    Awspec::Stub.load 'route53_hosted_zone'
  end
  let(:route53_hosted_zone) { Awspec::Generator::Spec::Route53HostedZone.new }
  it 'generate_by_domain_name generate spec' do
    spec = <<-'EOF'
describe route53_hosted_zone('example.com.') do
  it { should exist }
  its(:resource_record_set_count) { should eq 8 }
  it { should have_record_set('example.com.').a('123.456.7.890').ttl(3600) }
  it { should have_record_set('*.example.com.').cname('example.com').ttl(3600) }
  it { should have_record_set('example.com.').mx('10 mail.example.com').ttl(3600) }
  it { should have_record_set('mail.example.com.').a('123.456.7.890').ttl(3600) }
  it { should have_record_set('www.example.com.').a('123.456.7.890').ttl(600) }
  it { should have_record_set('example.com.').ns('ns-123.awsdns-45.net.
ns-6789.awsdns-01.org.
ns-2345.awsdns-67.co.uk.
ns-890.awsdns-12.com.').ttl(172800) }
  it { should have_record_set('s3.example.com.').alias('s3-website-us-east-1.amazonaws.com.', 'Z2ABCDEFGHIJKL') }
  it { should have_record_set('example.com.').caa('0 issue "amazon.com"
0 issue "amazontrust.com"
0 issue "awstrust.com"
0 issuewild "amazonaws.com"
0 iodef "mailto:support@example.com"').ttl(600) }
end
EOF
    expect(route53_hosted_zone.generate_by_domain_name('example.com.').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
