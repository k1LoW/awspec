module Awspec::Generator
  module Doc
    module Type
      class AlbListener < Base
        # rubocop:disable Metrics/LineLength
        def initialize
          super
          @type_name = 'AlbListener'
          @type = Awspec::Type::AlbListener.new('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
