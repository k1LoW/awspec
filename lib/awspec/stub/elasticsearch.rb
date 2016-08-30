
Aws.config[:elasticsearchservice] = {
  stub_responses: {
    list_domain_names: {
      domain_names: [
        {
          domain_name: 'my-elasticsearch'
        }
      ]
    },
    describe_elasticsearch_domain: {
      domain_status: {
        domain_id: '123456789012/streaming-logs',
        domain_name: 'my-elasticsearch',
        arn: 'arn:aws:es:us-east-1:123456789012:domain/streaming-logs',
        created: true,
        deleted: false,
        endpoint: 'search-streaming-logs-okga24ftzsbz2a2hzhsqw73jpy.us-east-1.es.a9.com',
        processing: false,
        elasticsearch_version: '2.3',
        elasticsearch_cluster_config: {
          instance_type: 't2.micro.elasticsearch',
          instance_count: 3,
          dedicated_master_enabled: true,
          zone_awareness_enabled: false,
          dedicated_master_type: 'm3.medium.elasticsearch',
          dedicated_master_count: 3
        },
        ebs_options: {
          ebs_enabled: true,
          volume_size: 10,
          volume_type: 'gp2'
        },
        access_policies: <<-EOS.gsub(/\n/, '').gsub(/ /, '')
{
  "version": "2012-10-17",
  "statement": [
    {
      "effect": "allow",
      "principal": "*",
      "action": [
        "es:*"
      ],
      "resource": "arn:aws:es:ap-northeast-1:1234567890:domain/my-elasticsearch/*"
    }
  ]
}
EOS
      }
    }
  }
}
