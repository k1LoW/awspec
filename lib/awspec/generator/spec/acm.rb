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
<%- certificate.domain_validation_options.each do |domain_validation_option| -%>
<%- unless domain_validation_option.validation_status.nil? -%>
  it { should have_domain_validation_option(domain_name: '<%= domain_validation_option.domain_name %>', validation_method: '<%= domain_validation_option.validation_method%>', validation_status: '<%= domain_validation_option.validation_status %>') }
<%- else -%>
  it { should have_domain_validation_option(domain_name: '<%= domain_validation_option.domain_name %>', validation_method: '<%= domain_validation_option.validation_method%>') }
<%- end -%>
<%- end -%>
end
<% end %>
EOF
        template
      end
    end
  end
end
