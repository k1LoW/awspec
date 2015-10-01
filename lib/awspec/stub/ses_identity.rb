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
    }
  }
}
