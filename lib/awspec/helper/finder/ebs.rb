module Awspec::Helper
  module Finder
    module Ebs
      def find_ebs(volume_id)
        res = ec2_client.describe_volumes({
                                            filters: [{ name: 'volume-id', values: [volume_id] }]
                                          })
        resource = res.volumes.single_resource(volume_id)
        return resource if resource
        res = ec2_client.describe_volumes({
                                            filters: [{ name: 'tag:Name', values: [volume_id] }]
                                          })
        res.volumes.single_resource(volume_id)
      end

      def select_ebs_by_instance_id(id)
        res = find_ec2(id)
        volumes = []
        return volumes unless res
        res.block_device_mappings.each do |block|
          volume = find_ebs(block.ebs.volume_id)
          volumes.push(volume) if volume
        end
        volumes
      end

      def select_all_attached_ebs
        selected = []
        res = ec2_client.describe_volumes

        loop do
          selected += res.volumes.select { |v| v.attachments.count > 0 }
          break if res.next_token.nil?
          res = ec2_client.describe_volumes({
                                              next_token: res.next_token
                                            })
        end

        selected
      end
    end
  end
end
