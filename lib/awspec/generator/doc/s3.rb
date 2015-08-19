module Awspec::Generator
  module Doc
    class S3 < Base
      def initialize
        @type_name = 'S3'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::S3.new('my-bucket')
        @ret = @type.bucket
        @matchers = []
        @ignore_matchers = []
        @describes = []
      end
    end
  end
end
