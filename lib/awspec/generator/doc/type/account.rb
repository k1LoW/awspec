module Awspec::Generator
  module Doc
    module Type
      class Account < Base
        def initialize
          super
          @type_name = 'Account'
          @type = Awspec::Type::Account.new
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end

        def generate_doc
          @account_spec = ERB.new(account_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
          super
        end

        def account_spec_template
          template = <<-'EOF'
describe account do
<% @ret.members.each do |key| %>
<%- if @ret[key].is_a?(String) -%>
  its(:<%= key %>) { should eq '<%= @ret[key] %>' }
<%- else -%>
<% @ret[key].members.each do |attribute| %>
<%- if @ret[key][attribute].is_a?(Array) -%>
  its('<%= key %>.<%= attribute %>') { should eq <%= @ret[key][attribute] %> }
<%- elsif @ret[key][attribute].is_a?(String) -%>
  its('<%= key %>.<%= attribute %>') { should eq '<%= @ret[key][attribute] %>' }
<%- elsif @ret[key][attribute].is_a?(Struct) -%>
<% @ret[key][attribute].members.each do |k| %>
  its('<%= key %>.<%= attribute %>.<%= k %>') { should eq <%= @ret[key][attribute][k] %> }
<% end %>
<%- else -%>
  its('<%= key %>.<%= attribute %>') { should eq <%= @ret[key][attribute] %> }
<%- end -%>
<% end %>
<% end %>
<%- end -%>
end
EOF
          template
        end

        def doc_template
          template = <<-'EOF'
## <a name="<%= @type_name.gsub(/ /, '_').underscore %>"><%= @type_name.gsub(/ /, '_').underscore %></a>

<%= @type_name %> resource type.
<%- if @descriptions.include?('first') -%><%= @descriptions['first'] %><%- end -%>

```ruby
<%= @account_spec %>```

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
