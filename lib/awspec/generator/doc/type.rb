module Awspec::Generator
  module Doc
    module Type
      def self.generate_doc
        Aws.config[:stub_responses] = true
        types = Awspec::Helper::Type::TYPES
        types.delete('base')
        links = types.map do |type|
          '[' + type + '](#' + type + ')'
        end
        header = <<-'EOF'
# Resource Types

<%= links.join("\n| ") %>

EOF
        doc = ERB.new(header, nil, '-').result(binding)

        types.map do |type|
          doc += eval "Awspec::Generator::Doc::Type::#{type.camelize}.new.generate_doc"
        end

        # account and attributes
        attributes = Awspec::Helper::Type::ACCOUNT_ATTRIBUTES

        doc += <<-'EOF'

# Account and Attributes

EOF
        doc += Awspec::Generator::Doc::Type::Account.new.generate_doc

        links = attributes.map do |type|
          '[' + type + '](#' + type + ')'
        end

        doc += links.join("\n| ")

        attributes.map do |type|
          doc += eval "Awspec::Generator::Doc::Type::#{type.camelize}.new.generate_doc"
        end

        doc.sub(/\n*\z/, '')
      end
    end
  end
end
