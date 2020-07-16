module Awspec::Generator
  module Spec
    class Route53HostedZone
      include Awspec::Helper::Finder
      def generate_by_domain_name(id)
        hosted_zone = find_hosted_zone(id)
        raise 'Not Found Route53 Hosted Zone' unless hosted_zone
        id = hosted_zone[:id]
        selected = []
        res = @route53_client.list_resource_record_sets({
                                                          hosted_zone_id: id
                                                        })
        loop do
          selected += res.resource_record_sets
          break unless res.is_truncated

          res = @route53_client.list_resource_record_sets({
                                                            hosted_zone_id: id,
                                                            start_record_name: res.next_record_name,
                                                            start_record_type: res.next_record_type
                                                          })
        end

        resource_record_sets = selected.map do |record_set|
          generate_linespec(record_set)
        end

        content = ERB.new(route53_hosted_zone_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
      end

      def generate_linespec(record_set)
        name = record_set.name.gsub(/\\052/, '*') # wildcard support
        if !record_set.resource_records.empty?
          template = <<-'EOF'
<% if record_set[:failover] -%>
it { should have_record_set('<%= name %>').<%= type %>('<%= v %>').ttl(<%= record_set.ttl %>).failover('<%= record_set.failover %>') }
<%- else -%>
it { should have_record_set('<%= name %>').<%= type %>('<%= v %>').ttl(<%= record_set.ttl %>) }
<% end -%>
EOF
          v = record_set.resource_records.map { |r| r.value }.join("\n")
          type = record_set.type.downcase
        else
          # ALIAS
          dns_name = record_set.alias_target.dns_name
          hosted_zone_id = record_set.alias_target.hosted_zone_id
          template = <<-'EOF'
<% if record_set[:failover] -%>
it { should have_record_set('<%= name %>').alias('<%= dns_name %>', '<%= hosted_zone_id %>').failover('<%= record_set.failover %>') }
<%- else -%>
it { should have_record_set('<%= name %>').alias('<%= dns_name %>', '<%= hosted_zone_id %>') }
<% end -%>
EOF
        end
        ERB.new(template, nil, '-').result(binding)
      end

      def route53_hosted_zone_spec_template
        template = <<-'EOF'
describe route53_hosted_zone('<%= hosted_zone.name %>') do
  it { should exist }
  its(:resource_record_set_count) { should eq <%= hosted_zone.resource_record_set_count %> }
<% resource_record_sets.each do |line| %>
  <%= line %>
<% end %>
end
EOF
        template
      end
    end
  end
end
