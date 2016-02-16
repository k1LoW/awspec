module Awspec::Generator
  module Spec
    class Ebs
      include Awspec::Helper::Finder
      def generate_all
        volumes = select_all_attached_ebs
        raise 'Not Found EBS' if volumes.empty?
        specs = volumes.map do |volume|
          attachment_specs = generate_attachment_specs(volume)
          content = ERB.new(ebs_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def generate_attachment_specs(volume)
        linespecs = []
        volume.attachments.each do |attachment|
          instance = find_ec2(attachment.instance_id)
          linespecs.push(ERB.new(attachment_linetemplate, nil, '-').result(binding)) if attachment.instance_id
        end
        linespecs
      end

      def attachment_linetemplate
        template = <<-'EOF'
<%- if instance.tag_name -%>
it { should be_attached_to('<%= instance.tag_name %>') }
<%- else -%>
it { should be_attached_to('<%= instance.instance_id %>') }
<%- end -%>
EOF
        template
      end

      def ebs_spec_template
        template = <<-'EOF'
<%- if volume.tag_name -%>
describe ebs('<%= volume.tag_name %>') do
<%- else -%>
describe ebs('<%= volume.volume_id %>') do
<%- end -%>
  it { should exist }
  it { should be_<%= volume.state.tr('-', '_') %> }
  its(:size) { should eq <%= volume.size %> }
  its(:volume_type) { should eq '<%= volume.volume_type %>' }
<% attachment_specs.each do |line| %>
  <%= line %>
<% end %>
end
EOF
        template
      end
    end
  end
end
