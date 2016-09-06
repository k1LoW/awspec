Aws.config[:waf] = {
  stub_responses: {
    list_web_acls: {
      next_marker: nil,
      web_acls: [
        {
          web_acl_id: '1234567-abcd-1234-efgh-5678-1234567890',
          name: 'my-waf-web-acl'
        }
      ]
    },
    get_web_acl: {
      web_acl: {
        web_acl_id: '1234567-abcd-1234-efgh-5678-1234567890',
        name: 'my-waf-web-acl',
        metric_name: 'mywafwebacl',
        default_action: {
          type: 'BLOCK'
        },
        rules: [
          {
            priority: 1,
            rule_id: 'aaaaaaaa-0000-5555-3333-eeeeeeeeeeee',
            action: {
              type: 'ALLOW'
            }
          },
          {
            priority: 2,
            rule_id: 'dddddddd-1111-2222-3333-eeeeeeeeeeee',
            action: {
              type: 'BLOCK'
            }
          }
        ]
      }
    },
    list_rules: {
      next_marker: nil,
      rules: [
        {
          rule_id: 'dddddddd-1111-2222-3333-eeeeeeeeeeee',
          name: 'my-waf-web-acl-allowed-ips'
        }
      ]
    },
    get_rule: {
      rule: {
        rule_id: 'dddddddd-1111-2222-3333-eeeeeeeeeeee',
        name: 'my-waf-web-acl-allowed-ips',
        metric_name: 'mywafwebaclallowedips',
        predicates: [
          {
            negated: false,
            type: 'IPMatch',
            data_id: '22aa22bb-3333-aaaa-8888-bbbbbbbbbbbb'
          }
        ]
      }
    }
  }
}
