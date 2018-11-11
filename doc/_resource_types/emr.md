### exist

```ruby
describe emr('my-emr') do
  it { should exist }
end
```
### be_healthy

```ruby
describe emr('my-emr') do
  it { should be_healthy }
end
```
### be_running, be_waiting, be_starting, be_bootstrapping

```ruby
describe emr('my-emr') do
  it { should be_running }
end
```
