module Awspec::Generator
  module Doc
    module Type
      class BackupPlan < Base
        def initialize
          super
          @type_name = 'BackupPlan'
          @type = Awspec::Type::BackupPlan.new('my-backup-plan')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
