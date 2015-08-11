module Awspec::Type
  class Subnet < Base
    attr_reader :subnet

    def initialize(id)
      super
      @subnet = find_subnet(id)
      @id = @subnet[:subnet_id] if @subnet
    end

    states = %w(
      available pending
    )

    states.each do |state|
      define_method state + '?' do
        @subnet[:state] == state
      end
    end

    def method_missing(name)
      describe = name.to_sym
      if @subnet.members.include?(describe)
        @subnet[describe]
      else
        super
      end
    end
  end
end
