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
        ERB.new(bucket_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
      end
    end
  end
end
