# Contributing

## Add new resource type (ex. Redshift resource)

1. Create your feature branch (`git checkout -b add-type-redshift`)
2. Generate template files (`bundle exec bin/toolbox template redshift`)
3. Fill files with code.
4. `bundle update` to update gems.
5. Generate [doc/resource_types.md](resource_types.md) (`bundle exec rake generate_docs`)
6. Run test (`bundle exec rake spec`)
7. Push to the branch (`git push origin add-type-redshift`)
8. Create a new Pull Request

### Troubleshooting

#### CI Failed 'Awspec::Generator::Doc::Type generate_doc output should be the same as doc/resource_types.md'

Maybe, your `aws-sdk-ruby` is not latest. Please exec `bundle update` and `bundle exec rake generate_docs`.

( `aws-sdk-ruby` is often updated. )

## Add new account attribute type (ex. CloudFormation::Client#describe_account_attributes )

1. Create your feature branch (`git checkout -b add-type-cf-limit`)
2. Generate template files (`bundle exec bin/toolbox template cloudformation_account_attributes -a`) **with -a option**
3. Fill files with code.
4. Generate [doc/resource_types.md](resource_types.md) (`bundle exec rake generate_docs`)
5. Run test (`bundle exec rake spec`)
6. Push to the branch (`git push origin add-type-cf-limit`)
7. Create a new Pull Request

## Append resource type document (ex. VPC resource `be_available`)

1. Create vpc.md (`touch doc/_resource_types/vpc.md`)
2. Write following document.

<pre>
### be_available
(Write cool description)
```ruby
describe vpc('my-vpc') do
   it { should be_available }
end
```
</pre>
