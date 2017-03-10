### first

```ruby
describe ec2_account_attributes do
  its(:supported_platforms) { should include 'VPC' }
  its(:max_instances) { should eq 20 }
end
```
