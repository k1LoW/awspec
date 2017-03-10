module Awspec::Generator
  module Doc
    module Type
      class AccountAttribute < Base
        def initialize
          Awspec::Stub.load 'account'
          @type_name = 'Account Attribute'
          @type = Awspec::Type::Account.new
          @ret = Awspec::Type::Account.new.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end

        def generate_doc
          @account_attribute_spec = ERB.new(account_attribute_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
          super
        end

        def account_attribute_spec_template
          template = <<-'EOF'
<% @ret.members.each do |key| %>
<%- next if @ret[key].is_a?(String) -%>
describe account_attribute('<%= key %>') do
<% @ret[key].members.each do |attribute| %>
<%- if @ret[key][attribute].is_a?(Array) -%>
  its('<%= attribute %>') { should eq <%= @ret[key][attribute] %> }
<%- elsif @ret[key][attribute].is_a?(String) -%>
  its('<%= attribute %>') { should eq '<%= @ret[key][attribute] %>' }
<%- elsif @ret[key][attribute].is_a?(Struct) -%>
<% @ret[key][attribute].members.each do |k| %>
  its('<%= attribute %>.<%= k %>') { should eq <%= @ret[key][attribute][k] %> }
<% end %>
<%- else -%>
  its('<%= attribute %>') { should eq <%= @ret[key][attribute] %> }
<%- end -%>
<% end %>
end
<%= ' ' %>
<% end %>
EOF
          template
        end

        def doc_template
          template = <<-'EOF'
## <a name="<%= @type_name.gsub(/ /, '_').underscore %>"><%= @type_name.gsub(/ /, '_').underscore %></a>

<%= @type_name %> resource type.
<%- if @descriptions.include?('first') -%><%= @descriptions['first'] %><%- end -%>

```ruby
<%= @account_attribute_spec %>```

<% @matchers.each do |matcher| %>
### <%= matcher %>
<%- if @descriptions.include?(matcher) -%><%= @descriptions[matcher] %><%- end -%>
<% end %>
<%- if @descriptions.include?('advanced') -%>

### :unlock: Advanced use
<%= @descriptions['advanced'] %><%- end -%>
EOF
          template
        end
      end
    end
  end
end
