module Awspec::Type
  class SesIdentity < Base
    def initialize(id)
      super
      @resource = find_ses_identity(id)
      @id = @resource if @resource
    end

    def has_identity_policy?(name)
      res = @ses_client.list_identity_policies({
                                                 identity: @id
                                               })
      res[:policy_names].find do |policy_name|
        policy_name == name
      end
    end
  end
end
