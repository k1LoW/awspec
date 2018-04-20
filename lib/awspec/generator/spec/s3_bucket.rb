module Awspec::Generator
  module Spec
    class S3Bucket
      include Awspec::Helper::Finder
      def generate_all
        buckets = select_all_buckets
        raise 'Not Found Bucket' if buckets.empty?
        specs = buckets.map do |bucket|
          content(bucket)
        end
        specs.join("\n")
      end

      def generate(bucket_name)
        bucket = find_bucket(bucket_name)
        content(bucket)
      end

      def generate_grant_specs(acl)
        return [] unless acl
        linespecs = []
        acl.grants.each do |grant|
          linespecs.push(ERB.new(grant_linetemplate, nil, '-').result(binding))
        end
        linespecs
      end

      def grant_linetemplate
        grantee = 'grant.grantee.display_name || grant.grantee.uri || grant.grantee.id'
        template = <<-EOF
it { should have_acl_grant(grantee: '<%= #{grantee} %>', permission: '<%= grant.permission %>') }
        EOF
        template
      end

      def generate_lifecycle_rule_transitions_spec(transitions_rule)
        rules = []
        transitions_rule.each do |line|
          elements = []
          line.each do |k, v|
            elements << case v
                        when Numeric
                          "#{k}: #{v}"
                        when String
                          "#{k}: '#{v}'"
                        else
                          "#{k}: '#{v.inspect}'"
                        end
          end
          rules << '{ ' + elements.join(', ') + ' }'
        end
        '[' + rules.join(', ') + ']'
      end

      def generate_lifecycle_rule_specs(lifecycle_rule)
        return [] unless lifecycle_rule
        linespecs = []
        lifecycle_rule.rules.each do |rule|
          transitions = generate_lifecycle_rule_transitions_spec(rule.transitions.map(&:to_h))
          template = <<-EOF
it do
    should have_lifecycle_rule(
      id: '<%= rule.id %>',
      <%- if rule.filter && rule.filter.prefix -%>
      filter: { prefix: '<%= rule.filter.prefix %>' },
      <%- end -%>
      <%- rule.noncurrent_version_expiration.to_h.each do |k, v| -%>
      noncurrent_version_expiration: { <%= k %>: <%= v %> },
      <%- end -%>
      <%- rule.expiration.to_h.each do |k, v| -%>
      expiration: { <%= k %>: <%= v %> },
      <%- end -%>
      transitions: <%= transitions %>,
      status: '<%= rule.status %>'
    )
  end
          EOF
          linespecs.push(ERB.new(template, nil, '-').result(binding))
        end
        linespecs
      end

      def bucket_spec_template
        template = <<-'EOF'
describe s3_bucket('<%= bucket.name %>') do
  it { should exist }
<%- if acl -%>
  its(:acl_owner) { should eq '<%= acl.owner.display_name %>' }
  its(:acl_grants_count) { should eq <%= acl.grants.count %> }
<%- end -%>
<% grant_specs.each do |line| %>
  <%= line %>
<% end %>
<%- if bucket_policy -%>
  it { should have_policy('<%= bucket_policy %>') }
<%- end -%>
<%- if tag -%>
  it { should have_tag('env').value('dev') }
<%- end -%>
<%- if lifecycle_rule -%>
<% lifecycle_specs.each do |line| %>
  <%= line %>
<% end %>
<%- end -%>
end
EOF
        template
      end

      private

      def content(bucket)
        acl = find_bucket_acl(bucket.name)
        grant_specs = generate_grant_specs(acl)
        tag = find_bucket_tag(bucket.name, 'env')
        policy = find_bucket_policy(bucket.name)
        bucket_policy = policy.policy.read if policy
        lifecycle_rule = find_bucket_lifecycle_configuration(bucket.name)
        lifecycle_specs = generate_lifecycle_rule_specs(lifecycle_rule) if lifecycle_rule
        ERB.new(bucket_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
      end
    end
  end
end
