# Contributing

## Add new resource type (ex. Redshift resource)

1. Create your feature branch (`git checkout -b add-type-redshift`)
2. Generate template files (`bundle exec ./lib/awspec/bin/toolbox template redshift`)
3. Fill files with code.
4. Generate [doc/resource_types.md](doc/resource_types.md) (`bundle exec ./lib/awspec/bin/toolbox docgen > doc/resource_type.md`)
5. Run test (`bundle exec rake spec`)
6. Push to the branch (`git push origin add-type-redshift`)
7. Create a new Pull Request

## Append resource type document (ex. VPC resource `be_available`)

1. Create vpc.md (`touch doc/_resource_types/vpc.md`)
2. Write following document.
```
### be_available
(Write cool description)
```ruby
describe vpc('my-vpc') do
   it { should be_available }
end
```
```
