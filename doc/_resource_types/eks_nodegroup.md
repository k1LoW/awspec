### exist

```ruby
describe eks_nodegroup('my-eks-nodegroup'), cluster: 'my-cluster' do
  it { should exist }
end
```
### be_active, be_creating

```ruby
describe eks('my-eks-nodegroup'), cluster: 'my-cluster' do
  it { should be_active }
end
```
