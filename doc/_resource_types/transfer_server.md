### exist

```ruby
describe transfer_server('s-4dc0a424f0154fa89') do
  it { should exist }
end

describe transfer_server('my-transfer-server') do
  it { should exist }
end
```

### be_offline, be_online, be_starting, be_stopping, be_start_failed, be_stop_failed

```ruby
describe transfer_server('s-4dc0a424f0154fa89') do
  it { should be_online }
end
```

### have_tag
```
describe transfer_server('s-4dc0a424f0154fa89') do
  it { should have_tag('env').value('dev') }
end
```

