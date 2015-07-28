# awspec [![Build Status](https://travis-ci.org/k1LoW/awspec.svg?branch=master)](https://travis-ci.org/k1LoW/awspec)

RSpec tests for your AWS resources.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'awspec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install awspec

## Usage

### 1. Generate awspec template

    $ awspec init

### 2. Write *_spec.rb

```ruby
describe ec2('i-ec12345a') do
  it { should be_running }
  its(:instance_id) { should eq 'i-ec12345a' }
  its(:image_id) { should eq 'ami-abc12def' }
  its(:public_ip_address) { should eq '123.0.456.789' }
  it { should have_security_group('my-security-group-name') }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_subnet('subnet-1234a567') }
  it { should have_eip('123.0.456.789') }
end
```

## Support AWS Resources

- [X] EC2
- [X] RDS
    - [ ] RDS DB Parameter
- [X] Security Group

### Next..

- [ ] VPC
- [ ] S3
- [ ] Route53
- ...

## Contributing

1. Fork it ( https://github.com/k1LoW/awspec/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## References

- Original idea (code / architecture) is [Serverspec](https://github.com/serverspec/serverspec)
- [Serverspec book](http://www.oreilly.co.jp/books/9784873117096/)

