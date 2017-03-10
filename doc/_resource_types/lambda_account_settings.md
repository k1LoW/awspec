### first

```ruby
describe lambda_account_settings do
  its('total_code_size.limit') { should eq 80_530_636_800 }
  its('total_code_size.usage') { should eq 2_034_651_562 }
  its('function_count.usage') { should eq 8 }
end
```

