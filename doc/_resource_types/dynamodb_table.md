### exist

```ruby
describe dynamodb_table('my-dynamodb-table') do
  it { should exist }
end
```

### be_active

```ruby
describe dynamodb_table('my-dynamodb-table') do
  it { should be_active }
end
```

### have_attribute_definition

```ruby
describe dynamodb_table('my-dynamodb-table') do
  it { should have_attribute_definition('my-dynamodb-table-attaribute1').attribute_type('S') }
  it { should have_attribute_definition('my-dynamodb-table-attaribute2').attribute_type('N') }
end
```

### have_key_schema

```ruby
describe dynamodb_table('my-dynamodb-table') do
  it { should have_key_schema('my-dynamodb-table-key_schema1').key_type('HASH') }
  it { should have_key_schema('my-dynamodb-table-key_schema2').key_type('RANGE') }
end
```

### advanced

`dynamodb_table` can use `Aws::DynamoDB::Table` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/DynamoDB/Table.html).

```ruby
describe dynamodb_table('my-dynamodb-table') do
  its('key_schema.first.key_type') { should eq 'HASH' }
end
```

or

```ruby
describe dynamodb_table('my-dynamodb-table') do
  its('resource.key_schema.first.key_type') { should eq 'HASH' }
end
```

