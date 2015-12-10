module Awspec
  class ResourceReader
    class CalledMethodInBlackList < StandardError
    end

    def initialize(resource)
      @resource = resource
    end

    def method_missing(name, *args)
      if match_black_list?(name)
        raise CalledMethodInBlackList, "Method call #{name.inspect} is black-listed"
      else
        attr = @resource.send(name)
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
      !!(BLACK_LIST_RE =~ name)
    end
  end
end
