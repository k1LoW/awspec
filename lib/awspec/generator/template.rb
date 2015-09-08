module Awspec::Generator
  class Template
    def self.generate(type)
      @type = type
      @root_path = File.dirname(__FILE__) + '/../../../'
      generate_stub
      generate_type
      generate_type_spec
      generate_generator_doc
      put_message
    end

    def self.generate_type
      path = 'lib/awspec/type/' + @type.to_snake_case + '.rb'
      full_path = @root_path + path
      content = <<-"EOF"
module Awspec::Type
  class #{@type.to_camel_case} < Base
    def initialize(id)
      super
      # @id = # @FIXME
    end
  end
end
EOF
      self.file_check_and_puts(path, content)
    end

    def self.generate_stub
      path = 'lib/awspec/stub/' + @type.to_snake_case + '.rb'
      full_path = @root_path + path
      content = <<-"EOF"
# Aws.config[:ec2] = {
#   stub_responses: true
# }
EOF
      self.file_check_and_puts(path, content)
    end

    def self.generate_type_spec
      path = 'spec/type/' + @type.to_snake_case + '_spec.rb'
      full_path = @root_path + path
      content = <<-"EOF"
require 'spec_helper'
Awspec::Stub.load '#{@type.to_snake_case}'

describe #{@type.to_snake_case}('my-#{@type.to_snake_case.tr('_', '-')}') do
  it { should exist }
end
EOF
      self.file_check_and_puts(path, content)
    end

    def self.generate_generator_doc
      path = 'lib/awspec/generator/doc/type/' + @type.to_snake_case + '.rb'
      full_path = @root_path + path
      content = <<-"EOF"
module Awspec::Generator
  module Doc
    module Type
      class #{@type.to_camel_case} < Base
        def initialize
          super
          @type_name = '#{@type.to_camel_case}'
          @type = Awspec::Type::#{@type.to_camel_case}.new('my-#{@type.to_snake_case.tr('_', '-')}')
          @ret = @type.resource
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

    def self.put_message
      content = <<-"EOF"

Genarate #{@type.to_camel_case} template files.

* !! AND add '#{@type.to_snake_case}' to Awspec::Helper::Type::TYPES in awspec/lib/helper/type.rb *

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
