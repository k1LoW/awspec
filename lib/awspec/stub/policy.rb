Aws.config[:iam] = {
  stub_responses: {
    list_policies: {
      policies: [
        {
          attachment_count: 1,
          arn: 'arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator',
          is_attachable: true,
          policy_name: 'AmazonAPIGatewayAdministrator',
          update_date: Time.new(2015, 7, 9, 17, 34, 45, '+00:00')
        },
        {
          attachment_count: 1,
          arn: 'arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforDataPipelineRole',
          is_attachable: true,
          policy_name: 'AmazonEC2RoleforDataPipelineRole',
          update_date: Time.new(2015, 3, 19, 19, 21, 14, '+00:00')
        }
      ]
    },
    list_entities_for_policy: {
      policy_roles: [
        { role_name: 'HelloIAmGodRole' }
      ]
    }
  }
}
