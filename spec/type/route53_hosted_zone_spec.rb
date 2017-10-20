require 'spec_helper'
Awspec::Stub.load 'route53_hosted_zone'

describe route53_hosted_zone('example.com.') do
  it { should exist }
  its(:resource_record_set_count) { should eq 8 }
  it { should have_record_set('example.com.').a('123.456.7.890') }
  it { should have_record_set('*.example.com.').cname('example.com') }
  it { should have_record_set('example.com.').mx('10 mail.example.com') }
  it { should have_record_set('mail.example.com.').a('123.456.7.890').ttl(3600) }
  ns = 'ns-123.awsdns-45.net.
ns-6789.awsdns-01.org.
ns-2345.awsdns-67.co.uk.
ns-890.awsdns-12.com.'
  it { should have_record_set('example.com.').ns(ns) }
  it { should have_record_set('s3.example.com.').alias('s3-website-us-east-1.amazonaws.com.', 'Z2ABCDEFGHIJKL') }
  caa = '0 issue "amazon.com"
0 issue "amazontrust.com"
0 issue "awstrust.com"
0 issuewild "amazonaws.com"
0 iodef "mailto:support@example.com"'
  it { should have_record_set('example.com.').caa(caa).ttl(600) }
end

describe route53_hosted_zone('example.com.') do
  context 'route53_hosted_zone support wildcard format' do
    it { should have_record_set('\052.example.com.').cname('example.com') }
    it { should have_record_set('*.example.com.').cname('example.com') }
  end
end

describe route53_hosted_zone('Z1A2BCDEF34GH5') do
  it { should exist }
  its(:resource_record_set_count) { should eq 8 }
end

describe route53_hosted_zone('example.com.') do
  context 'route53_hosted_zone support no order gurantee record value' do
    ns1 = 'ns-123.awsdns-45.net.
ns-6789.awsdns-01.org.
ns-2345.awsdns-67.co.uk.
ns-890.awsdns-12.com.'
    it { should have_record_set('example.com.').ns(ns1) }
    ns2 = 'ns-6789.awsdns-01.org.
ns-123.awsdns-45.net.
ns-890.awsdns-12.com.
ns-2345.awsdns-67.co.uk.'
    it { should have_record_set('example.com.').ns(ns2) }
  end
end

describe route53_hosted_zone('example.com.') do
  context 'route53_hosted_zone support without ttl option in multiple ttls' do
    # TTL of first A record (example.com.) is 3600, but TTL of target A record is 600.
    it { should have_record_set('www.example.com.').a('123.456.7.890') }
  end
end
