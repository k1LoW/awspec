module Awspec::Type
  class ResourceBase < Base
    attr_reader :id, :resource_via_client, :params

    def initialize(display_name = nil, params = {})
      @display_name = display_name
      @params = params.nil? ? {} : params
      @id = nil
    end

    def exists?
      id
    end

    def id
      raise 'this method must be override!'
    end

    def self.aws_resource(resource)
      define_method :resource do
        @resource ||= Awspec::ResourceReader.new(resource.new(id))
      end
    end
  end
end
