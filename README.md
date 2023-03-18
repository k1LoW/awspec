# awspec [![Gem](https://img.shields.io/gem/v/awspec.svg)](https://rubygems.org/gems/awspec) [![CI](https://github.com/k1LoW/awspec/actions/workflows/ci.yml/badge.svg)](https://github.com/k1LoW/awspec/actions)

![Logo](./awspec-logo.png)

RSpec tests for your AWS resources.

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

If you're starting on a fresh RSpec project, you can use awspec to generate your init files:

    $ awspec init

If you're working on an existing RSpec project, you will need to add the following lines to your `spec_helper.rb` file:

```ruby
require 'awspec'
Awsecrets.load(secrets_path: File.expand_path('./secrets.yml', File.dirname(__FILE__)))
```

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

### STEP 3. Write spec/\*\_spec.rb

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

#### Using shared_context: region

```ruby
require 'spec_helper'

describe sqs('my-sqs-queue'), region: 'us-west-2' do
  it { should exist }
  its(:queue_url) { should eq 'https://sqs.us-west-2.amazonaws.com/xxxxxxxxxxxx/my-sqs-queue' }
  its(:queue_arn) { should eq 'arn:aws:sqs:us-west-2:xxxxxxxxxxxx:my-sqs-queue' }
  its(:visibility_timeout) { should eq '30' }
  its(:maximum_message_size) { should eq '256000' }
  its(:message_retention_period) { should eq '86400' }
  its(:delay_seconds) { should eq '0' }
  its(:receive_message_wait_time_seconds) { should eq '10' }
end
```

#### Using terraform outputs as identifier

Especially in cases, where resources created by terraform have the same names (e.g. created by VPC module), it is helpful to use terraform outputs as unique identifiers.

```terraform
output "my_ec2_instance" {
    value = aws_instance.my_instance.id
}
```

```ruby
require 'spec_helper'

my_ec2_instance = `terraform output my_ec2_instance`.strip

describe ec2(my_ec2_instance) do
  it { should be_running }
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
Add gem "rake" in your Gemfile if you are starting a blank project.

    $ bundle exec rake spec

### Advanced Tips: Spec generate command

Generate spec from AWS resources already exists.

```sh
$ awspec generate ec2 vpc-ab123cde >> spec/ec2_spec.rb
```

Make sure you have added in your spec file
```ruby
require 'spec_helper'
```

### Advanced Tips: Use Shared Credentials (~/.aws/config ~/.aws/credentials)

```sh
$ awspec generate ec2 vpc-ab123cde --profile mycreds
```

```sh
$ AWS_PROFILE=mycreds bundle exec rake spec
```

### Advanced Tips: Configuring the AWS client retries

The [`ClientWrap` class](https://github.com/k1LoW/awspec/blob/master/lib/awspec/helper/client_wrap.rb)
provides mechanisms for retrying AWS API calls when it receives a
`RequestLimitExceeded` error. `ClientWrap` implements a backoff algorithm
where the client will sleep for successively longer periods of time until the
algorithm has calculated a backoff greater than or equal to the
`backoff_limit`, at which point it will give up and re-raise the error. You
can see the full implementation in `ClientWrap#method_missing`.

You can configure this retry and backoff logic in your `spec_helper.rb`:

```ruby
require 'awspec'

# These are the defaults, but you can change them.
Awspec.configure do |config|
  config.client_backoff 0.0
  config.client_backoff_limit 30
  config.client_iteration 1
end
```

## Support AWS Resources

[Resource Types information here](doc/resource_types.md)

## awspec AWS key/secrets precedence

Dependent on [awsecrets](https://github.com/k1LoW/awsecrets#awsecrets-config-precedence).

## References

awspec is inspired by Serverspec.

- Original idea (code / architecture) -> [Serverspec](https://github.com/serverspec/serverspec)
- `AWS + Serverspec` original concept -> https://github.com/marcy-terui/awspec
- [Serverspec book](http://www.oreilly.co.jp/books/9784873117096/)
