module Awspec::Helper
  module Finder
    module Cloudtrail
      def select_all_trails
        cloudtrail_client.describe_trails.trail_list
      end

      def find_trail(id)
        ret = cloudtrail_client.describe_trails.trail_list.find do |trail|
          trail.name == id
        end
      end
    end
  end
end
