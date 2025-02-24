# frozen_string_literal: true

Aws.config[:wafv2] = {
  stub_responses: {
    get_web_acl: {
      web_acl: {
        name: 'my-wafv2-web-acl',
        id: 'a64cc988-40ec-4c4e-ab80-c9acbea42103',
        arn: 'arn:aws:wafv2:ap-northeast-1:123456789012:regional/webacl/'\
             'my-wafv2-web-acl/a64cc988-40ec-4c4e-ab80-c9acbea42103',
        default_action: {
          allow: {}
        },
        description: 'test web acl',
        rules: [
          {
            name: 'AWS-AWSManagedRulesCommonRuleSet',
            priority: 0,
            statement: {
              managed_rule_group_statement: {
                vendor_name: 'AWS',
                name: 'AWSManagedRulesCommonRuleSet'
              }
            },
            override_action: {
              none: {}
            },
            visibility_config: {
              sampled_requests_enabled: true,
              cloud_watch_metrics_enabled: true,
              metric_name: 'AWS-AWSManagedRulesCommonRuleSet'
            }
          },
          {
            name: 'AWS-AWSManagedRulesKnownBadInputsRuleSet',
            priority: 1,
            statement: {
              managed_rule_group_statement: {
                vendor_name: 'AWS',
                name: 'AWSManagedRulesKnownBadInputsRuleSet'
              }
            },
            override_action: {
              none: {}
            },
            visibility_config: {
              sampled_requests_enabled: true,
              cloud_watch_metrics_enabled: true,
              metric_name: 'AWS-AWSManagedRulesKnownBadInputsRuleSet'
            }
          },
          {
            name: 'AWS-AWSManagedRulesLinuxRuleSet',
            priority: 2,
            statement: {
              managed_rule_group_statement: {
                vendor_name: 'AWS',
                name: 'AWSManagedRulesLinuxRuleSet'
              }
            },
            override_action: {
              none: {}
            },
            visibility_config: {
              sampled_requests_enabled: true,
              cloud_watch_metrics_enabled: true,
              metric_name: 'AWS-AWSManagedRulesLinuxRuleSet'
            }
          },
          {
            name: 'AWS-AWSManagedRulesUnixRuleSet',
            priority: 3,
            statement: {
              managed_rule_group_statement: {
                vendor_name: 'AWS',
                name: 'AWSManagedRulesUnixRuleSet'
              }
            },
            override_action: {
              none: {}
            },
            visibility_config: {
              sampled_requests_enabled: true,
              cloud_watch_metrics_enabled: true,
              metric_name: 'AWS-AWSManagedRulesUnixRuleSet'
            }
          },
          {
            name: 'AWS-AWSManagedRulesAnonymousIpList',
            priority: 4,
            statement: {
              managed_rule_group_statement: {
                vendor_name: 'AWS',
                name: 'AWSManagedRulesAnonymousIpList'
              }
            },
            override_action: {
              none: {}
            },
            visibility_config: {
              sampled_requests_enabled: true,
              cloud_watch_metrics_enabled: true,
              metric_name: 'AWS-AWSManagedRulesAnonymousIpList'
            }
          },
          {
            name: 'AWS-AWSManagedRulesAmazonIpReputationList',
            priority: 5,
            statement: {
              managed_rule_group_statement: {
                vendor_name: 'AWS',
                name: 'AWSManagedRulesAmazonIpReputationList'
              }
            },
            override_action: {
              none: {}
            },
            visibility_config: {
              sampled_requests_enabled: true,
              cloud_watch_metrics_enabled: true,
              metric_name: 'AWS-AWSManagedRulesAmazonIpReputationList'
            }
          }
        ],
        visibility_config: {
          sampled_requests_enabled: true,
          cloud_watch_metrics_enabled: true,
          metric_name: 'my-wafv2-web-acl'
        },
        capacity: 1275,
        managed_by_firewall_manager: false,
        label_namespace: 'awswaf:123456789012:webacl:my-wafv2-web-acl:',
        retrofitted_by_firewall_manager: false
      },
      'lock_token': '8060f9d3-6437-4457-934c-e20bc0440e04'
    },
    list_web_acls: {
      next_marker: 'my-wafv2-web-acl',
      web_acls: [
        {
          name: 'my-wafv2-web-acl',
          id: 'a64cc988-40ec-4c4e-ab80-c9acbea42103',
          description: '',
          lock_token: '8060f9d3-6437-4457-934c-e20bc0440e04',
          arn: 'arn:aws:wafv2:ap-northeast-1:123456789012:regional/webacl/'\
               'my-wafv2-web-acl/a64cc988-40ec-4c4e-ab80-c9acbea42103'
        }
      ]
    }
  }
}
