module Awspec::Type
  class AccountAttribute < Base
    def initialize(key = nil)
      @key = key.to_sym
    end

    def resource_via_client
      attributes = nil
      Awspec::Helper::Type::ACCOUNT_ATTRIBUTES.each do |type|
        key = type.gsub(Awspec::Type::Account::REMOVE_SUFFIX_RE, '').to_sym
        next unless key == @key
        if key == 'ses'
          # https://docs.aws.amazon.com/ses/latest/DeveloperGuide/regions.html
          next unless ['us-east-1', 'us-west-2', 'eu-west-1'].include?(Aws.config[:region])
        end
        eval "attributes = Awspec::Type::#{type.camelize}.new.resource_via_client"
      end
      @resource_via_client ||= attributes
    end

    def method_missing(name)
      name = name.to_s if name.class == Symbol
      describe = name.tr('-', '_').to_sym
      super unless resource_via_client.members.include?(describe)
      resource_via_client[describe]
    end
  end
end
