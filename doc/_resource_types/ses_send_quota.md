### its(:max_send_rate), its(:max_send_rate), its(:sent_last_24_hours)

```ruby
describe ses_send_quota('AWS AccountID Number') do
  its(:max_24_hour_send) { should eq '200'.to_f }
  its(:max_send_rate) { should eq '1'.to_f }
  its(:sent_last_24_hours) { should eq '1'.to_f }
end
```
