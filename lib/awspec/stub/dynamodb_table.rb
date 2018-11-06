Aws.config[:dynamodb] = {
  stub_responses: {
    describe_table: {
      table: {
        table_name: 'my-dynamodb-table',
        table_status: 'ACTIVE',
        provisioned_throughput: {
          read_capacity_units: 1,
          write_capacity_units: 1
        },
        attribute_definitions: [
          {
            attribute_name: 'my-dynamodb-table-attribute1',
            attribute_type: 'S'
          },
          {
            attribute_name: 'my-dynamodb-table-attribute2',
            attribute_type: 'N'
          }
        ],
        key_schema: [
          {
            attribute_name: 'my-dynamodb-table-key_schema1',
            key_type: 'HASH'
          },
          {
            attribute_name: 'my-dynamodb-table-key_schema2',
            key_type: 'RANGE'
          }
        ]
      }
    }
  }
}
