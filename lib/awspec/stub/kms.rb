Aws.config[:kms] = {
  stub_responses: {
    list_aliases: {
      aliases: [
        {
          alias_arn: 'arn:aws:kms:us-east-1:1234567890:alias/my-kms-key',
          alias_name: 'alias/my-kms-key',
          target_key_id: 'b9989d41-eeaa-401f-8616-00546948aa92'
        },
        {
          alias_arn: 'arn:aws:kms:us-east-1:1234567890:alias/aws/example',
          alias_name: 'alias/aws/example'
        }
      ]
    },
    describe_key: {
      key_metadata: {
        key_id:  'b9989d41-eeaa-401f-8616-00546948aa92',
        description: '',
        enabled: true,
        key_usage: 'ENCRYPT_DECRYPT',
        key_state: 'Enabled',
        creation_date: Time.new(2015, 1, 2, 10, 10, 00, '+00:00'),
        arn: 'arn:aws:kms:us-east-1:1234567890:key/b9989d41-eeaa-401f-8616-00546948aa92',
        aws_account_id: '1234567890'
      }
    },
    get_key_policy: {
      policy: <<-DOC
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
    }
  }
}
