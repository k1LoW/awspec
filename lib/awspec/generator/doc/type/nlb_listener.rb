module Awspec::Generator
  module Doc
    module Type
      class NlbListener < Base
        # rubocop:disable Metrics/LineLength
        def initialize
          super
          @type_name = 'NlbListener'
          @type = Awspec::Type::NlbListener.new('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-nlb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
