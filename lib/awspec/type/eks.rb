module Awspec::Type
  class Eks < ResourceBase
    def initialize(name)
      super
      @name = name
    end

    def resource_via_client
      @resource_via_client ||= find_eks_cluster(@name)
    end

    def id
      @id ||= resource_via_client.name if resource_via_client
    end

    STATES = %w(ACTIVE CREATING)

    STATES.each do |state|
      define_method state.downcase + '?' do
        resource_via_client.status == state
      end
    end
  end
end
