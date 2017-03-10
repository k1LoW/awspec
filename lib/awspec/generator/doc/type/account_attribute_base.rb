module Awspec::Generator
  module Doc
    module Type
      class AccountAttributeBase < Base
        def initialize
          Awspec::Stub.load 'account'
          @type_name = type_name
        end

        def doc_template
          template = <<-'EOF'
## <a name="<%= @type_name.gsub(/ /, '_').underscore %>"><%= @type_name.gsub(/ /, '_').underscore %></a>

<%= @type_name %> account attributes.
<%- if @descriptions.include?('first') -%><%= @descriptions['first'] %><%- end -%>
<% @matchers.each do |matcher| %>
### <%= matcher %>
<%- if @descriptions.include?(matcher) -%><%= @descriptions[matcher] %><%- end -%>
<% end %>
<%- unless its.empty? -%>### <%= its.join(', ') %><%- end -%>
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
