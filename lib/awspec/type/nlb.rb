module Awspec::Type
  class Nlb < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_nlb(@display_name)
    end

    def id
      @id ||= resource_via_client.load_balancer_name if resource_via_client
    end

    STATES = %w(
      active provisioning failed
    )

    STATES.each do |state|
      define_method state + '?' do
        resource_via_client.state.code == state
      end
    end

    def has_security_group?(_sg_id)
      false
    end

    def has_subnet?(subnet_id)
      azs = resource_via_client.availability_zones
      ret = azs.find do |az|
        az.subnet_id == subnet_id
      end
      return true if ret
      subnet2 = find_subnet(subnet_id)
      subnet2.subnet_id = subnet_id
    end
  end
end
