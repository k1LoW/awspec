Aws.config[:elasticloadbalancingv2] = {
  stub_responses: {
    describe_load_balancers: {
      load_balancers: [
        {
          load_balancer_name: 'my-alb',
          dns_name: 'my-load-balancer-123456789.us-west-1.elb.amazonaws.com'
        }
      ]
    }
  }
}
