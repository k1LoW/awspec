# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class BackupSelection < Base
        def initialize
          super
          @type_name = 'BackupSelection'
          @type = Awspec::Type::BackupSelection.new('my-backup-selection')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
