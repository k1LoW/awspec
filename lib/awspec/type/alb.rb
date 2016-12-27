module Awspec::Type
  class Alb < Base
    def resource_via_client
      @resource_via_client ||= find_alb(@display_name)
    end

    def id
      @id = resource_via_client.load_balancer_name if resource_via_client
    end

    def dns_name
puts "KSM: dns_name: #{@resource_via_client.dns_name}"
      @resource_via_client.dns_name
    end
  end
end
