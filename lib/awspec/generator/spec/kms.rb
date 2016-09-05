module Awspec::Generator
  module Spec
    class Kms
      include Awspec::Helper::Finder
      def generate_all
        aliases = select_all_kms_aliases
        raise 'Not Found alias' if aliases.empty?
        ERB.new(keys_spec_template, nil, '-').result(binding).chomp
      end

      def keys_spec_template
        template = <<-'EOF'
<% aliases.each do |kms_alias| %>
describe kms('<%= kms_alias.alias_name.split('/').last %>') do
  it { should exist }
<% if find_kms_key(kms_alias.target_key_id).enabled -%>
  it { should be_enable }
<% end -%>
end
<% end %>
EOF
        template
      end
    end
  end
end
