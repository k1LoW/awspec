module Awspec
  class Toolbox < Thor
    desc 'docgen > doc/resource_types.md', 'Generate doc/resource_types.md document'
    def docgen
      puts Awspec::Generator::Doc::Type.generate_doc
    end

    desc 'template [resource_type_name]', 'Generate template files'
    option :account_attribute, type: :boolean, default: false, aliases: :a
    def template(type)
      if options[:account_attribute]
        puts Awspec::Generator::Template.generate_account_attribute(type)
      else
        puts Awspec::Generator::Template.generate(type)
      end
    end
  end
end
