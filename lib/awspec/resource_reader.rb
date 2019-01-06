module Awspec
  module BlackListForwardable
    class CalledMethodInBlackList < StandardError
    end

    def method_missing_via_black_list(name, delegate_to: nil)
      raise ArgumentError, 'delegate_to: must be specified' unless delegate_to
      if match_black_list?(name) && !match_white_list?(name)
        raise CalledMethodInBlackList, "Method call #{name.inspect} is black-listed"
      end
      attr = delegate_to.send(name)
      if !attr.is_a?(Struct) && attr.class.name.match(/^Aws::/)
        ResourceReader.new(attr)
      else
        attr
      end
    end

    private

    BLACK_LIST_RE = /
      clear|
      create|delete|put|update|add|
      attach|detach|
      reboot|start|stop|terminate|
      modify|reset|replace|
      authorize|revoke|
      deregister|enable_|remove
    /ix

    def match_black_list?(name)
      BLACK_LIST_RE =~ name
    end

    WHITE_LIST_RE = /password_reset_required|attached_policies/ix

    def match_white_list?(name)
      WHITE_LIST_RE =~ name
    end
  end

  class ResourceReader
    include BlackListForwardable

    def initialize(resource)
      @resource_via_client = resource
    end

    # TODO: this method is specific to DynamoDB and probably should be moved somewhere else
    def describe_time_to_live(*args)
      @resource_via_client.send('describe_time_to_live', *args)
    end

    def method_missing(name)
      method_missing_via_black_list(name, delegate_to: @resource_via_client)
    end
  end
end
