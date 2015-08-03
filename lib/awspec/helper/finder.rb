require 'aws-sdk'

module Awspec
  module Helper
    module Finder
      attr_reader :ec2_client

      # rubocop:disable all
      def initialize(id = nil)
        @ec2_client = Aws::EC2::Client.new
        @rds_client = Aws::RDS::Client.new
        @route53_client = Aws::Route53::Client.new
        @s3_client = Aws::S3::Client.new
      end
      # rubocop:enable all

      def find_vpc(id)
        res = @ec2_client.describe_vpcs({
                                          filters: [{ name: 'vpc-id', values: [id] }]
                                        })
        return res[:vpcs][0] if res[:vpcs].count == 1
        res = @ec2_client.describe_vpcs({
                                          filters: [{ name: 'tag:Name', values: [id] }]
                                        })
        return res[:vpcs][0] if res[:vpcs].count == 1
      end

      def find_route_table(id)
        res = @ec2_client.describe_route_tables({
                                                  filters: [{ name: 'route-table-id', values: [id] }]
                                                })
        return res[:route_tables][0] if res[:route_tables].count == 1
        res = @ec2_client.describe_route_tables({
                                                  filters: [{ name: 'tag:Name', values: [id] }]
                                                })
        return res[:route_tables][0] if res[:route_tables].count == 1
      end

      def find_network_acl(id)
        res = @ec2_client.describe_network_acls({
                                                  filters: [{ name: 'network-acl-id', values: [id] }]
                                                })
        return res[:network_acls][0] if res[:network_acls].count == 1
        res = @ec2_client.describe_network_acls({
                                                  filters: [{ name: 'tag:Name', values: [id] }]
                                                })
        return res[:network_acls][0] if res[:network_acls].count == 1
      end

      def find_security_group(id)
        res = @ec2_client.describe_security_groups({
                                                     filters: [{ name: 'group-id', values: [id] }]
                                                   })

        return res[:security_groups][0] if res[:security_groups].count == 1
        res = @ec2_client.describe_security_groups({
                                                     filters: [{ name: 'group-name', values: [id] }]
                                                   })

        return res[:security_groups][0] if res[:security_groups].count == 1
        res = @ec2_client.describe_security_groups({
                                                     filters: [{ name: 'tag:Name', values: [id] }]
                                                   })

        return res[:security_groups][0] if res[:security_groups].count == 1
      end

      def find_ec2(id)
        if id.is_a?(Array)
          # Aws::EC2::Client.describe_instances native filters format
          res = @client.describe_instances({
                                             filters: id
                                           })
        elsif id.is_a?(Hash)
          # syntax sugar
          filters = []
          id.each do |k, v|
            filters.push({ name: k, values: Array(v) })
          end
          res = @client.describe_instances({
                                             filters: filters
                                           })
        else
          # instance_id or tag:Name
          begin
            res = @client.describe_instances({
                                               instance_ids: [id]
                                             })
          rescue
            # Aws::EC2::Errors::InvalidInstanceIDMalformed
            # Aws::EC2::Errors::InvalidInstanceIDNotFound
            res = @client.describe_instances({
                                               filters: [{ name: 'tag:Name', values: [id] }]
                                             })
          end
        end
        return res[:reservations][0][:instances][0] if res[:reservations][0][:instances].count == 1
      end

      def find_rds(id)
        # db_instance_identifier
        res = @rds_client.describe_db_instances({
                                                  db_instance_identifier: id
                                                })
        return res[:db_instances][0] if res[:db_instances].count == 1
      end

      def find_hosted_zone(id)
        hosted_zones = {}
        marker = nil
        loop do
          res = @route53_client.list_hosted_zones({
                                                    marker: marker
                                                  })
          marker = res.marker
          break if res.hosted_zones.empty?
          res.hosted_zones.each do |hosted_zone|
            hosted_zones[hosted_zone[:name]] = hosted_zones
            if hosted_zone[:name] == id || hosted_zone[:id] == '/hostedzone/' + id || hosted_zone[:id] == id
              return hosted_zone
            end
          end

          break if marker.nil?
        end
      end

      def find_bucket(id)
        res = @s3_client.list_buckets
        ret = @s3_client.list_buckets[:buckets].find do |bucket|
          bucket.name == id
        end
      end
    end
  end
end
