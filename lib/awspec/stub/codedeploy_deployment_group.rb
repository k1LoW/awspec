Aws.config[:codedeploy] = {
  stub_responses: {
    get_deployment_group: {
      deployment_group_info: {
        application_name: 'my-codedeploy-application',
        auto_scaling_groups: [
          {
            hook: 'my-autoscaling-group-hook',
            name: 'my-autoscaling-group'
          }
        ],
        deployment_config_name: 'CodeDeployDefault.OneAtATime',
        ec2_tag_filters: [
          {
            type: 'KEY_AND_VALUE',
            value: 'CodeDeployDemo',
            key: 'Name'
          }
        ],
        auto_rollback_configuration: {
          enabled: false
        },
        blue_green_deployment_configuration: {
          terminate_blue_instances_on_deployment_success: {
            action: 'TERMINATE',
            termination_wait_time_in_minutes: 5
          },
          deployment_ready_option: {
            action_on_timeout: 'CONTINUE_DEPLOYMENT',
            wait_time_in_minutes: 0
          }
        },
        deployment_group_id: 'cdac3220-0e64-4d63-bb50-e68faEXAMPLE',
        service_role_arn: 'arn:aws:iam::80398EXAMPLE:role/CodeDeployDemoRole',
        deployment_group_name: 'my-codedeploy-deployment-group'
      }
    }
  }
}
