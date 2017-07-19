Aws.config[:ec2] = {
  stub_responses: {
    describe_images: {
      images: [
        {
          image_id: 'ami-82640282',
          image_location:
            'aws-marketplace/CentOS Linux 6 x86_64 20150928_0-74e73035-3435-48d6-88e0-89cc02ad83ee-ami-2b35794e.2',
          state: 'available',
          owner_id: '123456789012',
          creation_date: '2015-10-13T23:00:25.000Z',
          public: true,
          product_codes: [
            {
              product_code_id: 'abcdefghijklmn01234567890',
              product_code_type: 'marketplace'
            }
          ],
          architecture: 'x86_64',
          image_type: 'machine',
          kernel_id: nil,
          ramdisk_id: nil,
          platform: nil,
          sriov_net_support: nil,
          state_reason: nil,
          image_owner_alias: 'aws-marketplace',
          name: 'my-ami',
          description: 'CentOS Linux 6 x86_64 HVM EBS 20150928_01',
          root_device_type: 'ebs',
          root_device_name: '/dev/sda1',
          block_device_mappings: [
            {
              virtual_name: nil,
              device_name: '/dev/sda1',
              ebs: {
                snapshot_id: 'snap-be484c23',
                volume_size: 8,
                delete_on_termination: false,
                volume_type: 'standard',
                iops: nil,
                encrypted: false
              },
              no_device: nil
            }
          ],
          virtualization_type: 'hvm',
          tags: [
            {
              key: 'stage',
              value: 'production'
            }
          ],
          hypervisor: 'xen'
        }
      ]
    }
  }
}
