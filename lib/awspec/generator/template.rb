module Awspec::Generator
  class Template
    def self.generate(type)
      @type = type
      @account_attribute = false
      @root_path = File.dirname(__FILE__) + '/../../../'
      generate_stub
      generate_type
      generate_type_spec
      generate_generator_doc
      generate_resource_type_doc
      put_message
    end

    def self.generate_account_attribute(type)
      @type = type
      @account_attribute = true
      @root_path = File.dirname(__FILE__) + '/../../../'
      generate_type
      generate_account_attribute_generator_doc
      generate_resource_type_doc
      put_message
    end

    def self.generate_type
      path = 'lib/awspec/type/' + @type.underscore + '.rb'
      base = @account_attribute ? 'AccountAttributeBase' : 'ResourceBase'
      content = <<-"EOF"
module Awspec::Type
  class #{@type.camelize} < #{base}
    def resource_via_client
      @resource_via_client ||= # FIXME
    end

    def id
     @id ||= # FIXME
    end
  end
end
EOF
      self.file_check_and_puts(path, content)
    end

    def self.generate_stub
      path = 'lib/awspec/stub/' + @type.underscore + '.rb'
      content = <<-"EOF"
# Aws.config[:ec2] = {
#   stub_responses: true
# }
EOF
      self.file_check_and_puts(path, content)
    end

    def self.generate_type_spec
      path = 'spec/type/' + @type.underscore + '_spec.rb'
      content = <<-"EOF"
require 'spec_helper'
Awspec::Stub.load '#{@type.underscore}'

describe #{@type.underscore}('my-#{@type.underscore.tr('_', '-')}') do
  it { should exist }
end
EOF
      self.file_check_and_puts(path, content)
    end

    def self.generate_generator_doc
      path = 'lib/awspec/generator/doc/type/' + @type.underscore + '.rb'
      content = <<-"EOF"
module Awspec::Generator
  module Doc
    module Type
      class #{@type.camelize} < Base
        def initialize
          super
          @type_name = '#{@type.camelize}'
          @type = Awspec::Type::#{@type.camelize}.new('my-#{@type.underscore.tr('_', '-')}')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
EOF
      self.file_check_and_puts(path, content)
    end

    def self.generate_account_attribute_generator_doc
      path = 'lib/awspec/generator/doc/type/' + @type.underscore + '.rb'
      content = <<-"EOF"
module Awspec::Generator
  module Doc
    module Type
      class #{@type.camelize} < AccountAttributeBase
        def initialize
          super
          @type_name = '#{@type.camelize}'
          @type = Awspec::Type::#{@type.camelize}.new
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
EOF
      self.file_check_and_puts(path, content)
    end

    def self.generate_resource_type_doc
      path = 'doc/_resource_types/' + @type.underscore + '.md'
      content = <<-"EOF"
### exist
EOF
      self.file_check_and_puts(path, content)
    end

    def self.put_message
      content = <<-"EOF"

Generate #{@type.camelize} template files.

* !! AND add '#{@type.underscore}' to Awspec::Helper::Type::TYPES in lib/awspec/helper/type.rb *
* !! AND add '#{@type.underscore}' client to lib/awspec/helper/finder.rb *

EOF
    end

    def self.file_check_and_puts(path, content)
      if File.exist? @root_path + path
        $stderr.puts "!! #{path} already exists"
      else
        File.open(@root_path + path, 'w') do |f|
          f.puts content
        end
        puts " + #{path}"
      end
    end
  end
end
