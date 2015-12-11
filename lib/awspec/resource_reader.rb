module Awspec
  module BlackListForwardable
    class CalledMethodInBlackList < StandardError
    end

    def method_missing_via_black_list(name, delegate_to: nil)
      fail(ArguementError, 'delegate_to: must be specified') unless delegate_to
      if match_black_list?(name)
        fail CalledMethodInBlackList, "Method call #{name.inspect} is black-listed"
      else
        attr = delegate_to.send(name)
        case attr
        when Aws::Resources::Resource
          ResourceReader.new(attr)
        else
          attr
        end
      end
    end

    private

    BLACK_LIST_RE = /
      create|
      delete|
      clear|
      put|
      update|
      add
    /ix

    def match_black_list?(name)
      BLACK_LIST_RE =~ name
    end
  end

  class ResourceReader
    include BlackListForwardable

    def initialize(resource)
      @resource_via_client = resource
    end

    def method_missing(name)
      method_missing_via_black_list(name, delegate_to: @resource_via_client)
    end
  end
end
