module Awspec::Type
  class Emr < ResourceBase
    attr_reader :id

    def initialize(id)
      super
      @id = id
    end

    def resource_via_client
      @resource_via_client ||= find_emr_cluster(@id)
    end

    STARTING_STATES = %w(STARTING BOOTSTRAPPING)
    READY_STATES = %w(RUNNING WAITING)
    STATES = (READY_STATES + STARTING_STATES)

    STATES.each do |state|
      define_method state.downcase + '?' do
        resource_via_client.status.state == state
      end
    end

    def applications
      resource_via_client.applications.map { |a| { name: a.name, version: a.version } }
    end

    def tags
      resource_via_client.tags.map { |t| { t.key.to_sym => t.value } }
    end

    def ok?
      READY_STATES.include?(resource_via_client.status.state)
    end

    alias_method :healthy?, :ok?
    alias_method :ready?, :ok?
    alias_method :bootstrapping?, :starting?
  end
end
