RSpec::Matchers.define :belong_to_subnets do |*subnets|
  match do |nodegroup|
    superset = Set.new(subnets)
    nodegroup.subnets.subset?(superset)
  end
  failure_message { |nodegroup| super() + failure_reason(nodegroup) }
  failure_message_when_negated { |nodegroup| super() + failure_reason(nodegroup) }
end

private

def failure_reason(nodegroup)
  ", but the nodes are allocated to the subnets #{nodegroup.subnets.to_a}"
end
