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
      path = 'lib/awspec/type/' + @type.underscore + '.rb'
      full_path = @root_path + path
      content = <<-"EOF"
module Awspec::Type
  class #{@type.camelize} < Base
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
      path = 'lib/awspec/stub/' + @type.underscore + '.rb'
      full_path = @root_path + path
      content = <<-"EOF"
# Aws.config[:ec2] = {
#   stub_responses: true
# }
EOF
      self.file_check_and_puts(path, content)
    end

    def self.generate_type_spec
      path = 'spec/type/' + @type.underscore + '_spec.rb'
      full_path = @root_path + path
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
      full_path = @root_path + path
      content = <<-"EOF"
module Awspec::Generator
  module Doc
    module Type
      class #{@type.camelize} < Base
        def initialize
          super
          @type_name = '#{@type.camelize}'
          @type = Awspec::Type::#{@type.camelize}.new('my-#{@type.underscore.tr('_', '-')}')
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

Genarate #{@type.camelize} template files.

* !! AND add '#{@type.underscore}' to Awspec::Helper::Type::TYPES in awspec/lib/helper/type.rb *

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
