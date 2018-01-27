RSpec::Matchers.define :belong_to_nlb do |nlb_arn|
  match do |type|
    return true if type.load_balancer_arns.include?(nlb_arn)
    ret = type.find_nlb(nlb_arn)
    return false unless ret
    type.load_balancer_arns.include?(ret.load_balancer_arn)
  end
end
