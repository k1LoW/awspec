# awspec [![Gem](https://img.shields.io/gem/v/awspec.svg)](https://rubygems.org/gems/awspec) [![Travis](https://img.shields.io/travis/k1LoW/awspec.svg)](https://travis-ci.org/k1LoW/awspec) [![Scrutinizer](https://img.shields.io/scrutinizer/g/k1LoW/awspec.svg)](https://scrutinizer-ci.com/g/k1LoW/awspec/) [![Gemnasium](https://img.shields.io/gemnasium/k1LoW/awspec.svg)](https://gemnasium.com/k1LoW/awspec)

![Logo](./awspec-logo.png)

RSpec tests for your AWS resources.

[![Join the chat at https://gitter.im/k1LoW/awspec](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/k1LoW/awspec?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Resource Types](doc/resource_types.md) | [Contributing](doc/contributing.md)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'awspec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install awspec

## Getting Started

### STEP 1. Generate awspec init files

    $ awspec init

### STEP 2. Set AWS config

#### 2-1. Use Shared Credentials like AWS CLI

```sh
$ aws configure

...
```

(See http://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-chap-getting-started.html#config-settings-and-precedence)

#### 2-2. Use secrets.yml

```sh
$ cat <<EOF > spec/secrets.yml
region: ap-northeast-1
aws_access_key_id: XXXXXXXXXXXXXXXXXXXX
aws_secret_access_key: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
EOF
```

### STEP 3. Write spec/*_spec.rb

```ruby
require 'spec_helper'

describe ec2('my-ec2-tag-name') do
  it { should be_running }
  its(:instance_id) { should eq 'i-ec12345a' }
  its(:image_id) { should eq 'ami-abc12def' }
  its(:public_ip_address) { should eq '123.0.456.789' }
  it { should have_security_group('my-security-group-name') }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_subnet('subnet-1234a567') }
  it { should have_eip('123.0.456.789') }
  it { should be_disabled_api_termination }
end
```

### STEP 4. Run tests

    $ bundle exec rake spec

### Advanced Tips: Spec generate command

Generate spec from AWS resources already exists.

```sh
$ awspec generate ec2 vpc-ab123cde >> spec/ec2_spec.rb
```

### Advanced Tips: Use Shared Credentials (~/.aws/config ~/.aws/credentials)

```sh
$ awspec generate ec2 vpc-ab123cde --profile mycreds
```

```sh
$ AWS_PROFILE=mycreds bundle exec rake spec
```

## Support AWS Resources

[Resource Types infomation here](doc/resource_types.md)

## awspec AWS key/secrets precedence

Dependent on [awsecrets](https://github.com/k1LoW/awsecrets#awsecrets-config-precedence).

## References

awspec is inspired by Serverspec.

- Original idea (code / architecture) -> [Serverspec](https://github.com/serverspec/serverspec)
- `AWS + Serverspec` original concept -> https://github.com/marcy-terui/awspec
- [Serverspec book](http://www.oreilly.co.jp/books/9784873117096/)
