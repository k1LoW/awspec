module Awspec::Generator
  module Doc
    class Base
      def collect_matchers
        methods = @type.methods - Awspec::Helper::Finder.instance_methods - Object.methods
        methods.select! do |method|
          method.to_s.include?('?')
        end
        methods.map do |method|
          next 'exist' if 'exists?' == method.to_s
          next 'have_' + Regexp.last_match[1] if /\Ahas_(.+)\?\z/ =~ method.to_s
          next 'be_' + Regexp.last_match[1] if /\A(.+)\?\z/ =~ method.to_s
          method.to_s
        end
      end

      def doc_template
        template = <<-'EOF'
### <a name="<%= type_name.to_snake_case %>"><%= type_name.to_snake_case %></a>

<%= type_name %> resource type.
<% matchers.each do |matcher| %>
#### <%= matcher %>
<% end %>
#### <%= its.join(', ') %>

EOF
        template
      end
    end
  end
end
