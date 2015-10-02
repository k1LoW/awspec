Aws.config[:ses] = {
  stub_responses: {
    list_identities: {
      identities: [
        'example.com'
      ]
    },
    list_identity_policies: {
      policy_names: [
        'my-identity-policy-name'
      ]
    },
    get_identity_dkim_attributes: {
      dkim_attributes: {
        'example.com' => {
          dkim_enabled: false,
          dkim_verification_status: 'NotStarted',
          dkim_tokens: []
        }
      }
    },
    get_identity_notification_attributes: {
      notification_attributes: {
        'example.com' => {
          bounce_topic: 'arn:aws:sns:us-east-1:1234567890:my-sns-topic',
          complaint_topic: 'arn:aws:sns:us-east-1:1234567890:my-sns-topic',
          delivery_topic: 'arn:aws:sns:us-east-1:1234567890:my-sns-topic',
          forwarding_enabled: true
        }
      }
    },
    get_identity_verification_attributes: {
      verification_attributes: {
        'example.com' => {
          verification_status: 'Success',
          verification_token: 'XXXXXXXXXXXXXXXABCXXXXXXXXXXXXXXX'
        }
      }
    }
  }
}
