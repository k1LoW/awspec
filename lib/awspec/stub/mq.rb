Aws.config[:mq] = {
  stub_responses: {
    describe_broker: {
      auto_minor_version_upgrade: false,
      created: Time.new(2019, 1, 2, 10, 10, 00, '+00:00'),
      broker_arn: 'arn:aws:mq:us-east-1:910612559259:broker:broker_mq:b-abaf644d-49ed-382a-6fa0-d4034df1678e',
      broker_state: 'RUNNING',
      broker_id: 'b-abaf644d-49ed-382a-6fa0-d4034df1678e',
      broker_name: 'broker_mq',
      maintenance_window_start_time: {
        day_of_week: 'WEDNESDAY',
        time_zone: 'UTC',
        time_of_day: '23:00'
      },
      broker_instances: [
        {
          ip_address: '10.10.10.1',
          endpoints: [
            'ssl://b-abaf644d-49ed-382a-6fa0-d4034df1678e-1.mq.us-east-1.amazonaws.com:61617',
            'amqp+ssl://b-abaf644d-49ed-382a-6fa0-d4034df1678e-1.mq.us-east-1.amazonaws.com:5671',
            'stomp+ssl://b-abaf644d-49ed-382a-6fa0-d4034df1678e-1.mq.us-east-1.amazonaws.com:61614',
            'mqtt+ssl://b-abaf644d-49ed-382a-6fa0-d4034df1678e-1.mq.us-east-1.amazonaws.com:8883',
            'wss://b-abaf644d-49ed-382a-6fa0-d4034df1678e-1.mq.us-east-1.amazonaws.com:61619'
          ],
          console_url: 'https://b-abaf644d-49ed-382a-6fa0-d4034df1678e-1.mq.us-east-1.amazonaws.com:8162'
        },
        {
          ip_address: '10.10.11.1',
          endpoints: [
            'ssl://b-abaf644d-49ed-382a-6fa0-d4034df1678e-2.mq.us-east-1.amazonaws.com:61617',
            'amqp+ssl://b-abaf644d-49ed-382a-6fa0-d4034df1678e-2.mq.us-east-1.amazonaws.com:5671',
            'stomp+ssl://b-abaf644d-49ed-382a-6fa0-d4034df1678e-2.mq.us-east-1.amazonaws.com:61614',
            'mqtt+ssl://b-abaf644d-49ed-382a-6fa0-d4034df1678e-2.mq.us-east-1.amazonaws.com:8883',
            'wss://b-abaf644d-49ed-382a-6fa0-d4034df1678e-2.mq.us-east-1.amazonaws.com:61619'
          ],
          console_url: 'https://b-abaf644d-49ed-382a-6fa0-d4034df1678e-2.mq.us-east-1.amazonaws.com:8162'
        }
      ],
      publicly_accessible: false,
      configurations: {
        current: {
          id: 'c-c6064e54-7a02-4926-4028-78262d48e06f',
          revision: 3
        },
        history: [
          {
            id: 'c-c6064e54-7a02-4926-4028-78262d48e06f',
            revision: 2
          }
        ]
      },
      engine_version: '5.15.0',
      engine_type: 'ActiveMQ',
      deployment_mode: 'ACTIVE_STANDBY_MULTI_AZ',
      users: [
        {
          username: 'admin'
        }
      ],
      logs: {
        audit: false,
        general_log_group: '/aws/amazonmq/broker/b-abaf644d-49ed-382a-6fa0-d4034df1678e/general',
        general: true,
        audit_log_group: '/aws/amazonmq/broker/b-abaf644d-49ed-382a-6fa0-d4034df1678e/audit'
      },
      tags: {
        'Name' => 'my-mq'
      },
      subnet_ids: [
        'subnet-c102731fbf7b7abb9',
        'subnet-4efe21eb33f86ef91'
      ],
      host_instance_type: 'mq.m4.large',
      security_groups: [
        'sg-788eab237e47f1472'
      ]
    }
  }
}

Aws.config[:ec2] = {
  stub_responses: {
    describe_vpcs: {
      vpcs: [
        {
          vpc_id: 'vpc-ab123cde',
          tags: [
            {
              key: 'Name',
              value: 'my-mq'
            }
          ]
        }
      ]
    },
    describe_security_groups: {
      security_groups: [
        {
          group_id: 'sg-788eab237e47f1472',
          group_name: 'mq-group-name-sg',
          tags: [
            {
              key: 'Name',
              value: 'my-mq-sg'
            }
          ]
        }
      ]
    }
  }
}
