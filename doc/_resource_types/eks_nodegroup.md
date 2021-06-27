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

### be_ready

This matcher is not exactly you are expecting: it is different from what you can
see when looking at the AWS console at the Node Groups configuration and check
if the nodes Status is "Ready".

What you seeing over there is
[actually the same thing](https://aws.amazon.com/premiumsupport/knowledge-center/eks-node-status-ready/)
you would if using `kubectl`.

This matcher cannot do the same because it would involve using the Kubernetes
API: the AWS Ruby SDK currently doesn't expose this information.

What you can get from `be_ready` matcher is asserting that you have **at least**
the number of EC2 instances (the nodes in your EKS Node Group) are actually
in running state. It doesn't mean everything is fine, the node (EC2 instance)
can be running but without communication with the cluster or any order issue
regarding the Kubernetes configuration.

Although it might look an incomplete assertion, definitely the Node Group
"Status" won't be "Active" if the EC2 instances associated with it are not
running.

So, using this assertion like the sample below:

```ruby
describe eks('my-eks-nodegroup'), cluster: 'my-cluster' do
  it { should be_ready }
end
```

Will pass if at least the minimum expected (see `scaling_config`) number of EC2
instances are running.
