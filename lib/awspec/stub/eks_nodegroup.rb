Aws.config[:eks] = {
  stub_responses: {
    describe_nodegroup: {
      nodegroup: {
        version: '1.17',
        release_version: '1.17.12-20210322',
        cluster_name: 'my-cluster',
        nodegroup_name: 'my-nodegroup',
        nodegroup_arn: 'arn:aws:eks:us-west-2:012345678910:nodegroup/my-cluster/my-nodegroup/08bd000a',
        created_at: Time.parse('2018-10-28 00:23:32 -0400'),
        node_role: 'arn:aws:iam::012345678910:role/eks-nodegroup-role',
        status: 'ACTIVE'
      }
    }
  }
}
