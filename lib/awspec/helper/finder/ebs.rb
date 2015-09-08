module Awspec::Helper
  module Finder
    module Ebs
      def find_ebs(volume_id)
        res = @ec2_client.describe_volumes({
                                             filters: [{ name: 'volume-id', values: [volume_id] }]
                                           })
        return res[:volumes].first if res[:volumes].count == 1
        res = @ec2_client.describe_volumes({
                                             filters: [{ name: 'tag:Name', values: [volume_id] }]
                                           })
        return res[:volumes].first if res[:volumes].count == 1
      end

      def select_ebs_by_instance_id(id)
        res = find_ec2(id)
        volumes = []
        return volumes unless res
        res[:block_device_mappings].each do |block|
          volume = find_ebs(block.ebs.volume_id)
          volumes.push(volume) if volume
        end
        volumes
      end
    end
  end
end
