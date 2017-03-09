module Awspec::Type
  class Account < Base
    def resource_via_client
      attributes = sts_client.get_caller_identity.to_h
      Awspec::Helper::Type::ACCOUNT_ATTRIBUTES.each do |type|
        key = type.gsub(/_account_attributes/, '').to_sym
        if key == 'ses_send_quota'
          # https://docs.aws.amazon.com/ses/latest/DeveloperGuide/regions.html
          next unless ['us-east-1', 'us-west-2', 'eu-west-1'].include?(Aws.config[:region])
        end
        eval "attributes[key] = Awspec::Type::#{type.camelize}.new.resource_via_client"
      end
      @resource_via_client ||= attributes.to_struct
    end

    def id
      @id ||= sts_client.get_caller_identity.account
    end

    def method_missing(name)
      name = name.to_s if name.class == Symbol
      describe = name.tr('-', '_').to_sym
      return nil unless resource_via_client.members.include?(describe)
      resource_via_client[describe]
    end
  end
end
