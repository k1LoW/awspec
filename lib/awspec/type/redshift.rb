module Awspec::Type
  class Redshift < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_redshift_cluster_identifier(@display_name)
    end

    def id
      @id ||= resource_via_client.cluster_identifier if resource_via_client
    end

    STATES = %w(
      available cancelling-resize creating deleting
      final-snapshot hardware-failure incompatible-hsm
      incompatible-network incompatible-parameters incompatible-restore
      modifying rebooting renaming resizing rotating-keys
      storage-full updating-hsm
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        resource_via_client.cluster_status == state
      end
    end

    def has_security_group?(sg_id)
      return true if has_vpc_security_group_id?(sg_id)
      return true if has_vpc_security_group_name?(sg_id)
      return true if has_vpc_security_group_tag_name?(sg_id)
      return true if has_cluster_security_group_name?(sg_id)
    end

    def has_cluster_parameter_group?(name, parameter_apply_status = nil)
      pgs = resource_via_client.cluster_parameter_groups
      pgs.find do |pg|
        if parameter_apply_status.nil?
          pg.parameter_group_name == name
        else
          pg.parameter_group_name == name && \
            pg.parameter_apply_status == parameter_apply_status
        end
      end
    end

    def has_tag?(tag_key, tag_value)
      resource_via_client.tags do |tag|
        tag.key == tag_key && tag.value == tag_value
      end
    end

    private

    def has_vpc_security_group_id?(sg_id)
      sgs = resource_via_client.vpc_security_groups
      sgs.find do |sg|
        sg.vpc_security_group_id == sg_id
      end
    end

    def has_vpc_security_group_name?(sg_id)
      sgs = resource_via_client.vpc_security_groups
      res = ec2_client.describe_security_groups({
                                                  filters: [{ name: 'group-name', values: [sg_id] }]
                                                })
      return false unless res.security_groups.count == 1
      sgs.find do |sg|
        sg.vpc_security_group_id == res.security_groups.first.group_id
      end
    end

    def has_vpc_security_group_tag_name?(sg_id)
      sgs = resource_via_client.vpc_security_groups
      res = ec2_client.describe_security_groups({
                                                  filters: [{ name: 'tag:Name', values: [sg_id] }]
                                                })
      return false unless res.security_groups.count == 1
      sgs.find do |sg|
        sg.vpc_security_group_id == res.security_groups.first.group_id
      end
    end

    def has_cluster_security_group_name?(sg_id)
      sgs = resource_via_client.cluster_security_groups
      sgs.find do |sg|
        sg.cluster_security_group_name == sg_id
      end
    end
  end
end
