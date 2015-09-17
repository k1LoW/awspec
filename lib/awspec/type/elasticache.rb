module Awspec::Type
  class Elasticache < Base
    def initialize(id)
      super
      @resource = find_cache_cluster(id)
      @id = @resource[:cache_cluster_id] if @resource
    end
  end
end
