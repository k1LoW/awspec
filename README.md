# awspec [![Gem](https://img.shields.io/gem/v/awspec.svg)](https://rubygems.org/gems/awspec) [![Travis](https://img.shields.io/travis/k1LoW/awspec.svg)](https://travis-ci.org/k1LoW/awspec) [![Scrutinizer](https://img.shields.io/scrutinizer/g/k1LoW/awspec.svg)](https://scrutinizer-ci.com/g/k1LoW/awspec/) [![Gemnasium](https://img.shields.io/gemnasium/k1LoW/awspec.svg)](https://gemnasium.com/k1LoW/awspec)

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

### 1. Generate awspec init files

    $ awspec init

### 2. Set AWS credentials

#### 2-1. Use Shared Credentials

```sh
$ aws configure

...
```

#### 2-2. Use spec/secrets.yml

```sh
$ cat <<EOF > spec/secrets.yml
region: ap-northeast-1
aws_access_key_id: XXXXXXXXXXXXXXXXXXXX
aws_secret_access_key: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
EOF
```

### 3. Write spec/*_spec.rb

```ruby
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

### 4. Run tests

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
$ export AWS_PROFILE=mycreds; bundle exec rake spec
```

## Support AWS Resources

- [x] EC2 (`ec2`)
- [x] RDS (`rds`)
    - [x] RDS DB Parameter Group  (`rds_db_parameter_group`)
- [x] Security Group (`security_group`)
- [x] VPC (`vpc`)
- [x] S3 (`s3`)
- Route53
    - [x] Route53 Hosted Zone (`route53_hosted_zone`)
- AutoScaling
    - [x] AutoScaling Group (`autoscaling_group`)
- [x] Subnet (`subnet`)
- [x] RouteTable (`route_table`)
- [x] EBS Volume (`ebs`)
- [x] ELB (`elb`)
- [x] Lambda (`lambda`)
- IAM
    - [x] IAM User (`iam_user`)
    - [x] IAM Group (`iam_group`)
    - [x] IAM Role (`iam_role`)
    - [x] IAM Policy (`iam_policy`)
- [x] ElastiCache (`elasticache`)
    - [x] ElastiCache Cache Parameter Group (`elasticache_cache_parameter_group`)
- CloudWatch
    - [x] CloudWatch Alarm (`cloudwatch_alarm`)
- SES
    - [x] SES Identity (`ses_identity`)
- [x] NetworkAcl (`network_acl`)

[Resource Types more infomation here](doc/resource_types.md)

## References

awspec is inspired by Serverspec.

- Original idea (code / architecture) -> [Serverspec](https://github.com/serverspec/serverspec)
- `AWS + Serverspec` original concept -> https://github.com/marcy-terui/awspec
- [Serverspec book](http://www.oreilly.co.jp/books/9784873117096/)
