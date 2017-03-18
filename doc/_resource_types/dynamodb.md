### exist

```ruby
describe dynamodb('my-dynamodb-table') do
  it { should exist }
end
```

### be_active

```ruby
describe dynamodb('my-dynamodb-table') do
  it { should be_active }
end
```

### have_attribute_definition

```ruby
describe dynamodb('my-dynamodb-table') do
  it { should have_attribute_definition('my-dynamodb-table-attaribute1').attribute_type('S') }
  it { should have_attribute_definition('my-dynamodb-table-attaribute2').attribute_type('N') }
end
```

### have_key_schema

```ruby
describe dynamodb('my-dynamodb-table') do
  it { should have_key_schema('my-dynamodb-table-key_schema1').key_type('HASH') }
  it { should have_key_schema('my-dynamodb-table-key_schema2').key_type('RANGE') }
end
```
