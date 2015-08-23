module Awspec
  class Toolbox < Thor
    desc 'docgen > doc/resource_type.md', 'Generate doc/resource_type.md document'
    def docgen
      puts Awspec::Generator::Doc::Type.generate_doc
    end

    desc 'template [resource_type_name]', 'Generate template files'
    def template(type)
      puts Awspec::Generator::Template.generate(type)
    end
  end
end
