### first

```ruby
describe rds_account_attributes do
  its('DBInstances.used') { should eq 0 }
  its('DBInstances.max') { should eq 40 }
end
```
