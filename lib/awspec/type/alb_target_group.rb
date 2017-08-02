module Awspec::Type
  class AlbTargetGroup < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_alb_target_group(@display_name)
    end

    def id
      @id ||= resource_via_client.target_group_name if resource_via_client
    end

    def has_ec2?(id)
      ec2 = find_ec2(id)
      return nil unless ec2
      descriptions = elbv2_client.describe_target_health(
        target_group_arn: resource_via_client.target_group_arn
      ).target_health_descriptions
      descriptions.find do |description|
        description.target.id == ec2.instance_id
      end
    end
  end
end
