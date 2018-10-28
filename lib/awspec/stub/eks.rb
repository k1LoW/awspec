Aws.config[:eks] = {
  stub_responses: {
    describe_cluster: {
      cluster: {
        version: '1.10',
        name: 'devel',
        arn: 'arn:aws:eks:us-west-2:012345678910:cluster/devel',
        certificate_authority: {
          data: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2='
        },
        created_at: Time.parse('2018-10-28 00:23:32 -0400'),
        endpoint: 'https://A0DCCD80A04F01705DD065655C30CC3D.yl4.us-west-2.eks.amazonaws.com',
        resources_vpc_config: {
          security_group_ids: [
            'sg-6979fe18'
          ],
          subnet_ids: [
            'subnet-6782e71e',
            'subnet-e7e761ac'
          ],
          vpc_id: 'vpc-950809ec'
        },
        role_arn: 'arn:aws:iam::012345678910:role/eks-service-role',
        status: 'ACTIVE'
      }
    }
  }
}
