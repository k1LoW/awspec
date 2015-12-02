module Awspec::Generator
  module Spec
    class S3Bucket
      include Awspec::Helper::Finder
      def generate_all
        buckets = select_all_buckets
        buckets.empty? && fail('Not Found Bucket')
        specs = buckets.map do |bucket|
          acl = find_bucket_acl(bucket.name)
          grant_specs = generate_grant_specs(acl)
          content = ERB.new(bucket_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def generate_grant_specs(acl)
        linespecs = []
        acl.grants.each do |grant|
          linespecs.push(ERB.new(grant_linetemplate, nil, '-').result(binding))
        end
        linespecs
      end

      def grant_linetemplate
        template = <<-'EOF'
it { should have_acl_grant(grantee: '<%= grant.grantee.display_name %>', permission: '<%= grant.permission %>') }
EOF
        template
      end

      def bucket_spec_template
        template = <<-'EOF'
describe s3_bucket('<%= bucket.name %>') do
  it { should exist }
  its(:acl_grants_count) { should eq <%= acl.grants.count %> }
<% grant_specs.each do |line| %>
  <%= line %>
<% end %>
  its(:acl_owner) { should eq '<%= acl.owner.display_name %>' }
end
EOF
        template
      end
    end
  end
end
