module Awspec::Type
  class AccountAttributes < Base
    def resource_via_client
      attributes = {}
      Awspec::Helper::Type::ACCOUNT_ATTRIBUTES.each do |type|
        key = type.gsub(/_account_attributes/, '').to_sym
        eval "attributes[key] = Awspec::Type::#{type.camelize}.new.resource_via_client"
      end
      @resource_via_client ||= attributes.to_struct
    end

    def method_missing(name)
      name = name.to_s if name.class == Symbol
      describe = name.tr('-', '_').to_sym
      return nil unless resource_via_client.members.include?(describe)
      resource_via_client[describe]
    end
  end
end
