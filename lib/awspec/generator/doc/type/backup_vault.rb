# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class BackupVault < Base
        def initialize
          super
          @type_name = 'BackupVault'
          @type = Awspec::Type::BackupVault.new('my-backup-vault')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
