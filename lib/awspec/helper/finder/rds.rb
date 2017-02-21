module Awspec::Helper
  module Finder
    module Rds
      def find_rds(id)
        # db_instance_identifier
        res = rds_client.describe_db_instances({
                                                 db_instance_identifier: id
                                               })
        res.db_instances.single_resource(id)
      end

      def select_rds_by_vpc_id(vpc_id)
        res = rds_client.describe_db_instances
        res.db_instances.select do |db_instance|
          db_instance.db_subnet_group.vpc_id == vpc_id
        end
      end

      def find_rds_tags(name_or_arn, tag_key)
        begin
          tag_set = rds_client.list_tags_for_resource({ resource_name: name_or_arn })
        rescue Aws::RDS::Errors::InvalidParameterValue
          # Aws::RDS::Errors::InvalidParameterValue (invalid resource name : my-rds)
          res = rds_client.describe_db_instances
          instance = res.db_instances.detect do |db_instance|
            db_instance.db_instance_identifier == name_or_arn
          end
          arn = instance.db_instance_arn
          tag_set = rds_client.list_tags_for_resource({ resource_name: arn })
        end
        tag_query = tag_set.tag_list.find { |tag| tag.key == tag_key }
        return tag_query if tag_query
      end
    end
  end
end
