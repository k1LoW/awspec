module Awspec::Type
  class Acm < Base
    def resource_via_client
      @resource_via_client ||= find_certificate(@display_name)
    end

    def id
      @id = resource_via_client.certificate_arn if resource_via_client
    end

    def issued?
      resource_via_client.status == 'ISSUED'
    end
  end
end
