module Awspec::Type
  class Mq < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_broker(@display_name)
    end

    def id
      @id ||= resource_via_client.broker_id if resource_via_client
    end

    STATES = %w(
      running reboot-in-progress creation-in-progress
      creation-failed deletion-in-progress
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        resource_via_client.broker_state.downcase == state
      end
    end

    def has_security_group?(sg_id)
      return true if has_vpc_security_group_id?(sg_id)
      return true if has_vpc_security_group_name?(sg_id)
      return true if has_vpc_security_group_tag_name?(sg_id)
    end

    def has_tag?(tag_key, tag_value)
      @resource_via_client.tags do |tag|
        tag.key == tag_key && tag.value == tag_value
      end
    end

    private

    def has_vpc_security_group_id?(sg_id)
      sgs = @resource_via_client.security_groups
      sgs.find do |sg|
        sg == sg_id
      end
    end

    def has_vpc_security_group_name?(sg_id)
      res = select_security_group_by_group_name([sg_id])

      return false unless res.count == 1
      has_vpc_security_group_id?(res.first.group_id)
    end

    def has_vpc_security_group_tag_name?(sg_id)
      res = select_security_group_by_tag_name([sg_id])

      return false unless res.count == 1
      has_vpc_security_group_id?(res.first.group_id)
    end
  end
end
