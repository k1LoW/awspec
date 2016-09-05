### exist

```ruby
describe kms('my-kms-key') do
  it { should exist }
end
```

### be_enabled

```ruby
describe kms('my-kms-key') do
  it { should be_enabled }
end
```

### have_key_policy

```ruby
describe kms('my-kms-key') do
  it { should exist }
  it { should be_enabled }
  it do
    should have_key_policy('default').policy_document(<<-'DOC')
{
  "Version" : "2012-10-17",
  "Id" : "key-consolepolicy-2",
  "Statement" : [ {
    "Sid" : "Enable IAM User Permissions",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : "arn:aws:iam::1234567890:root"
    },
    "Action" : "kms:*",
    "Resource" : "*"
  }, {
    "Sid" : "Allow access for Key Administrators",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : "arn:aws:iam::1234567890:user/test-user"
    },
    "Action" : [ "kms:Create*", "kms:Describe*", "kms:Enable*", "kms:List*", "kms:Put*", "kms:Update*", "kms:Revoke*", "kms:Disable*", "kms:Get*", "kms:Delete*", "kms:ScheduleKeyDeletion", "kms:CancelKeyDeletion" ],
    "Resource" : "*"
  }, {
    "Sid" : "Allow use of the key",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : [ "arn:aws:iam::1234567890:user/test-user", "arn:aws:iam::1234567890:role/test-role" ]
    },
    "Action" : [ "kms:Encrypt", "kms:Decrypt", "kms:ReEncrypt*", "kms:GenerateDataKey*", "kms:DescribeKey" ],
    "Resource" : "*"
  }, {
    "Sid" : "Allow attachment of persistent resources",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : [ "arn:aws:iam::1234567890:user/test-user", "arn:aws:iam::1234567890:role/test-role" ]
    },
    "Action" : [ "kms:CreateGrant", "kms:ListGrants", "kms:RevokeGrant" ],
    "Resource" : "*",
    "Condition" : {
      "Bool" : {
        "kms:GrantIsForAWSResource" : "true"
      }
    }
  } ]
}
DOC
  end
end
```
