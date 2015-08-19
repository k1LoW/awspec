module Awspec::Generator
  module Doc
    class Rds < Base
      def generate_doc
        require File.dirname(__FILE__) + '/../../../../spec/stub/rds'
        type_name = 'RDS'
        @type = Awspec::Type::Rds.new('my-rds')
        matchers = %w(belong_to_vpc belong_to_subnet belong_to_db_subnet_group)
        matchers += collect_matchers
        describes = %w(vpc_id)
        describes += @type.instance.members.select do |describe|
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
