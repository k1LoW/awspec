# frozen_string_literal: true

Aws.config[:transfer] = {
  stub_responses: {
    describe_server: {
      server: Aws::Transfer::Types::DescribedServer.new(
        arn: 'arn:aws:transfer:us-east-1:1234567890:server/s-4dc0a424f0154fa89',
        domain: 'S3',
        endpoint_details: Aws::Transfer::Types::EndpointDetails.new(
          address_allocation_ids: %w[
            eipalloc-00000000000000001
            eipalloc-00000000000000002
            eipalloc-00000000000000003
          ],
          subnet_ids: %w[
            subnet-0000000000000000a
            subnet-0000000000000000b
            subnet-0000000000000000c
          ],
          vpc_endpoint_id: 'vpce-00000000000000001',
          vpc_id: 'vpc-0123456789abcdefg'
        ),
        endpoint_type: 'VPC',
        host_key_fingerprint: 'SHA256:0pj2UnuoFAKEfHrCZwfPwuFinG3RJEVir/m8bPRINTo=',
        identity_provider_type: 'SERVICE_MANAGED',
        logging_role: 'arn:aws:iam::1234567890:role/service-role/AWSTransferLoggingAccess',
        protocols: ['SFTP'],
        security_policy_name: 'TransferSecurityPolicy-2018-11',
        server_id: 's-4dc0a424f0154fa89',
        state: 'ONLINE',
        tags: [
          Aws::Transfer::Types::Tag.new(
            key: 'env',
            value: 'dev'
          )
        ],
        user_count: 13
      )
    }
  }
}
