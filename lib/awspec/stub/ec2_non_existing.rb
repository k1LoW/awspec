Aws.config[:ec2] = {
  stub_responses: {
    describe_instances: {
      reservations: []
    }
  }
}
