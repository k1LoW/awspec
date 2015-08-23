module Awspec
  class Toolbox < Thor
    desc 'docgen', 'Generate type template files'
    def docgen
      puts Awspec::Generator::Doc::Type.generate_doc
    end

    desc 'template [resource_type_name]', 'Generate resource_type template files'
    def template(type)
      puts Awspec::Generator::Template.generate(type)
    end
  end
end
