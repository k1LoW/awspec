# exist

```ruby
describe alb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should exist }
  its(:port) { should eq 80 }
  its(:protocol) { should eq 'HTTP' }
end
```
