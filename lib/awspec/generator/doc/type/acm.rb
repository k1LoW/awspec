module Awspec::Generator
  module Doc
    module Type
      class Acm < Base
        def initialize
          super
          @type_name = 'Acm'
          @type = Awspec::Type::Acm.new('example.jp')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Acm::STATUSES.map { |status| 'be_' + status.downcase }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::Acm::STATUSES.map { |status| 'be_' + status.downcase }
          @describes = []
        end
      end
    end
  end
end
