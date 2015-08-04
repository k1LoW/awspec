module Awspec::Helper
  module Finder
    module Rds
      def find_rds(id)
        # db_instance_identifier
        res = @rds_client.describe_db_instances({
                                                  db_instance_identifier: id
                                                })
        return res[:db_instances][0] if res[:db_instances].count == 1
      end
    end
  end
end
