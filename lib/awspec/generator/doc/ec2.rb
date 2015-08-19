module Awspec::Generator
  module Doc
    class Ec2 < Base
      def generate_doc
        require File.dirname(__FILE__) + '/../../../../spec/stub/ec2'
        type_name = 'EC2'
        @type = Awspec::Type::Ec2.new('my-ec2')
        matchers = %w(belong_to_vpc belong_to_subnet)
        matchers += collect_matchers
        describes = @type.instance.members.select do |describe|
          next true unless @type.instance[describe].is_a?(Array) || @type.instance[describe].is_a?(Hash)
        end
        its = describes.map do |describe|
          'its(:' + describe.to_s + ')'
        end
        ERB.new(doc_template, nil, '-').result(binding)
      end
    end
  end
end
