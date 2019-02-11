### exist

You can set the `application_name` (default: `default`).

```ruby
describe codedeploy_deployment_group('my-codedeploy-deployment-group'), application_name: 'my-codedeploy-application' do
  it { should exist }
end
```

### have_autoscaling_group

```ruby
describe codedeploy_deployment_group('my-codedeploy-deployment-group'), application_name: 'my-codedeploy-application' do
  it { should have_autoscaling_group('my-autoscaling-group') }
end
```
