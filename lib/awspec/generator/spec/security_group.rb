module Awspec::Generator
  module Spec
    class SecurityGroup
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
          group_id group_name
        )
        vpc = find_vpc(vpc_id)
        fail 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        sgs = select_security_group_by_vpc_id(@vpc_id)

        specs = sgs.map do |sg|
          linespecs = generate_linespecs(sg)
          inbound_rule_count = sg[:ip_permissions].reduce(0) do |sum, permission|
            sum += permission.ip_ranges.count + permission.user_id_group_pairs.count
          end
          outbound_rule_count = sg[:ip_permissions_egress].reduce(0) do |sum, permission|
            sum += permission.ip_ranges.count + permission.user_id_group_pairs.count
          end
          content = ERB.new(security_group_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def generate_linespecs(sg)
        linespecs = []
        permissions = { 'inbound' => sg.ip_permissions, 'outbound' => sg.ip_permissions_egress }
        %w(inbound outbound).each do |inout|
          permissions[inout].each do |permission|
            if permission.ip_protocol.to_i < 0 || permission.from_port.nil?
              linespecs.push('its(:' + inout + ') { should be_opened }')
              next
            end

            port = if permission.from_port == permission.to_port
                     permission.from_port
                   else
                     "'" + permission.from_port.to_s + '-' + permission.to_port.to_s + "'"
                   end

            protocol = permission.ip_protocol
            permission.ip_ranges.each do |ip_range|
              target = ip_range.cidr_ip
              linespecs.push(ERB.new(security_group_spec_linetemplate, nil, '-').result(binding))
            end
            permission.user_id_group_pairs.each do |group|
              target = group.group_name
              target = group.group_id unless group.group_name
              linespecs.push(ERB.new(security_group_spec_linetemplate, nil, '-').result(binding))
            end
          end
        end
        linespecs
      end

      def security_group_spec_linetemplate
        template = <<-'EOF'
its(:<%= inout %>) { should be_opened(<%= port %>).protocol('<%= protocol %>').for('<%= target %>') }
EOF
        template
      end

      def security_group_spec_template
        template = <<-'EOF'
describe security_group('<%= sg.group_name %>') do
  it { should exist }
<% describes.each do |describe| %>
<%- if sg.key?(describe) -%>
  its(:<%= describe %>) { should eq '<%= sg[describe] %>' }
<%- end -%>
<% end %>
<% linespecs.each do |line| %>
  <%= line %>
<% end %>
  its(:inbound_rule_count) { should eq <%= inbound_rule_count %> }
  its(:outbound_rule_count) { should eq <%= outbound_rule_count %> }
  its(:inbound_permissions_count) { should eq <%= sg.ip_permissions.count %> }
  its(:outbound_permissions_count) { should eq <%= sg.ip_permissions_egress.count %> }
<%- if @vpc_tag_name -%>
  it { should belong_to_vpc('<%= @vpc_tag_name %>') }
<%- else -%>
  it { should belong_to_vpc('<%= @vpc_id %>') }
<%- end -%>
end
EOF
        template
      end
    end
  end
end
