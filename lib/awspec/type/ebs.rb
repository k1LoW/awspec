module Awspec::Type
  class Ebs < Base
    def initialize(id)
      super
      @resource = find_ebs(id)
      @id = @resource[:volume_id] if @resource
    end

    states = %w(
      creating available in-use deleting deleted error
    )

    states.each do |state|
      define_method state.tr('-', '_') + '?' do
        @resource[:state] == state
      end
    end

    def attached_to?(instance_id)
      instance = find_ec2(instance_id)
      return false unless instance
      return false unless @resource[:attachments]
      @resource[:attachments][0][:instance_id] == instance[:instance_id] && \
        @resource[:attachments][0][:state] == 'attached'
    end
  end
end
