module Awspec::Generator
  module Doc
    class Ebs < Base
      def initialize
        @type_name = 'Ebs'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::Ebs.new('my-ebs')
        @ret = @type.volume
        @matchers = []
        @ignore_matchers = []
        @describes = []
      end
    end
  end
end
