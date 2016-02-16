# EC2
require 'awspec/matcher/belong_to_vpc'
require 'awspec/matcher/belong_to_subnet'
require 'awspec/matcher/have_tag'

# RDS
require 'awspec/matcher/belong_to_db_subnet_group'

# SecurityGroup
require 'awspec/matcher/be_opened'
require 'awspec/matcher/be_opened_only'

# Route53
require 'awspec/matcher/have_record_set'

# RouteTable
require 'awspec/matcher/have_route'

# IAM User
require 'awspec/matcher/belong_to_iam_group'

# IAM User/Group/Role
require 'awspec/matcher/be_allowed_action'

# ElastiCache
require 'awspec/matcher/belong_to_replication_group'
require 'awspec/matcher/belong_to_cache_subnet_group'

# CloudWatch
require 'awspec/matcher/belong_to_metric'

# NetworkAcl
require 'awspec/matcher/be_allowed'
require 'awspec/matcher/be_denied'
