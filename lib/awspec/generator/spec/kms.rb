module Awspec::Generator
  module Spec
    class Kms
      include Awspec::Helper::Finder
      def generate_all
        aliases = select_all_kms_aliases.select { |kms_alias| customer_managed_key?(kms_alias) }
        raise 'Not Found alias' if aliases.empty?
        ERB.new(keys_spec_template, nil, '-').result(binding).chomp
      end

      def keys_spec_template
        template = <<-'EOF'
<% aliases.each do |kms_alias| %>
describe kms('<%= kms_alias.alias_name.split('/').last %>') do
  it { should exist }
<% if find_kms_key(kms_alias.target_key_id).enabled -%>
  it { should be_enabled }
<% end -%>
end
<% end %>
EOF
        template
      end

      private

      def customer_managed_key?(kms_alias)
        # An aliase that has no target key id field is predefined by AWS.
        # see: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/KMS/Client.html#list_aliases-instance_method
        !kms_alias.target_key_id.nil?
      end
    end
  end
end
