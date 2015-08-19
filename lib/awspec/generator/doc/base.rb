module Awspec::Generator
  module Doc
    class Base
      def generate_doc
        @matchers += collect_matchers - @ignore_matchers
        @describes += @ret.members.select do |describe|
          next true unless @ret[describe].is_a?(Array) || @ret[describe].is_a?(Hash)
        end if @ret.respond_to?(:members)
        its = @describes.map do |describe|
          'its(:' + describe.to_s + ')'
        end
        ERB.new(doc_template, nil, '-').result(binding)
      end

      def collect_matchers
        methods = @type.methods - Awspec::Helper::Finder.instance_methods - Object.methods
        methods.select! do |method|
          method.to_s.include?('?')
        end
        methods.map! do |method|
          next 'exist' if 'exists?' == method.to_s
          next 'have_' + Regexp.last_match[1] if /\Ahas_(.+)\?\z/ =~ method.to_s
          next 'be_' + Regexp.last_match[1] if /\A(.+)\?\z/ =~ method.to_s
          method.to_s
        end
        methods.sort do |method|
          next -1 if method == 'exist'
          1
        end
      end

      def doc_template
        template = <<-'EOF'
### <a name="<%= @type_name.to_snake_case %>"><%= @type_name.to_snake_case %></a>

<%= @type_name %> resource type.
<% @matchers.each do |matcher| %>
#### <%= matcher %>
<% end %>
<%- unless its.empty? -%>#### <%= its.join(', ') %><%- end -%>


EOF
        template
      end
    end
  end
end
