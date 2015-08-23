module Awspec
  class Stub
    def self.load(type)
      require File.dirname(__FILE__) + '/stub/' + type
    end
  end
end
