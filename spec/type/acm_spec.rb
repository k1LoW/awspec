require 'spec_helper'
Awspec::Stub.load 'acm'

describe acm('example.jp') do
  its(:certificate_arn) { should eq 'arn:aws:acm:region:123456789010:certificate/12345678-1234-1234-1234-123456789000' }
end

describe acm('arn:aws:acm:region:123456789010:certificate/12345678-1234-1234-1234-123456789000') do
  it { should exist }
  it { should be_issued }
  it { should have_domain_name('example.jp') }
  its(:type) { should eq 'AMAZON_ISSUED' }
  it do
    should have_domain_validation_option(domain_name: 'example.jp',
                                         validation_method: 'DNS',
                                         validation_status: 'SUCCESS')
  end
end

describe acm('arn:aws:acm:region:123456789010:certificate/12345678-1234-1234-1234-123456789011') do
  it { should exist }
end

describe acm('example.com') do
  it 'should be a Exception when duplicated domain name' do
    expect { Awspec::Type::Acm.new('example.com').id }.to raise_error(
      Awspec::DuplicatedResourceTypeError
    )
  end
end
