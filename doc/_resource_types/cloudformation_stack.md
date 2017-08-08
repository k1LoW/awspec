### exist

```ruby
describe cloudformation_stack('my-cloudformation-stack') do
  it { should exist }
  its(:stack_status) { should eq 'UPDATE_COMPLETE' }
end
```
