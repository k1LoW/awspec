module Awspec::Type
  class Ebs < Base
    attr_reader :volume

    def initialize(id)
      super
      @volume = find_ebs(id)
      @id = @volume[:volume_id] if @volume
    end

    states = %w(
      creating available in-use deleting deleted error
    )

    states.each do |state|
      define_method state.gsub(/-/, '_') + '?' do
        @volume[:state] == state
      end
    end

    def method_missing(name)
      describe = name.to_sym
      if @volume.members.include?(describe)
        @volume[describe]
      else
        super
      end
    end

    def attached_to?(instance_id)
      instance = find_ec2(instance_id)
      return false unless instance
      return false unless @volume[:attachments]
      @volume[:attachments][0][:instance_id] == instance[:instance_id] && @volume[:attachments][0][:state] == 'attached'
    end
  end
end
