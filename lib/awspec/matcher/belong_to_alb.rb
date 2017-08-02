RSpec::Matchers.define :belong_to_alb do |alb_arn|
  match do |type|
    return true if type.load_balancer_arns.include?(alb_arn)
    ret = type.find_alb(alb_arn)
    return false unless ret
    type.load_balancer_arns.include?(ret.load_balancer_arn)
  end
end
