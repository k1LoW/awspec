# EC2
require 'awspec/matcher/belong_to_vpc'
require 'awspec/matcher/belong_to_subnet'

# RDS
require 'awspec/matcher/belong_to_db_subnet_group'

# SecurityGroup
require 'awspec/matcher/be_opened'

# Route53
require 'awspec/matcher/have_record_set'

# RouteTable
require 'awspec/matcher/have_route'
