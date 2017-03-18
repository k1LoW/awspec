module Awspec::Generator
  module Spec
    class Acm
      include Awspec::Helper::Finder
      def generate_all
        certificates = select_all_certificates
        raise 'Not Found Certificates' if certificates.empty?
        ERB.new(acm_spec_template, nil, '-').result(binding).chomp
      end

      def acm_spec_template
        template = <<-'EOF'
<% certificates.each do |certificate| %>
describe acm('<%= certificate.domain_name %>') do
  it { should exist }
<%- if certificate.status == 'ISSUED' -%>
  it { should be_issued }
<% end -%>
  its(:type) { should eq '<%= certificate.type %>' }
end
<% end %>
EOF
        template
      end
    end
  end
end
