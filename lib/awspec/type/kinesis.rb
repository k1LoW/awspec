module Awspec::Type
  class Kinesis < ResourceBase
    aws_resource Aws::Kinesis::Client

    def cache_values(res)
      @id = res.stream_name
      @stream_name = res.stream_name
      @stream_arn = res.stream_arn
      @stream_status = res.stream_status
      @retention_period_hours = res.retention_period_hours
      @stream_creation_timestamp = res.stream_creation_timestamp
      @enhanced_monitoring = res.enhanced_monitoring
      @encryption_type = res.encryption_type
      @key_id = res.key_id
      @open_shard_count = res.open_shard_count
    end

    def resource_via_client
      return @resource_via_client unless @resource_via_client.nil?
      @resource_via_client = find_kinesis_by_stream_name(@display_name)
    end

    def id
      cache_values(resource_via_client) if @id.nil?
      @id
    end

    def stream_name
      cache_values(resource_via_client) if @stream_name.nil?
      @stream_name
    end

    def stream_arn
      cache_values(resource_via_client) if @stream_arn.nil?
      @stream_arn
    end

    def stream_status
      cache_values(resource_via_client) if @stream_status.nil?
      @stream_status
    end

    def retention_period_hours
      cache_values(resource_via_client) if @retention_period_hours.nil?
      @retention_period_hours
    end

    def stream_creation_timestamp
      cache_values(resource_via_client) if @stream_creation_timestamp.nil?
      @stream_creation_timestamp
    end

    def enhanced_monitoring
      cache_values(resource_via_client) if @enhanced_monitoring.nil?
      @enhanced_monitoring
    end

    def encryption_type
      cache_values(resource_via_client) if @encryption_type.nil?
      @encryption_type
    end

    def key_id
      cache_values(resource_via_client) if @key_id.nil?
      @key_id
    end

    def open_shard_count
      cache_values(resource_via_client) if @open_shard_count.nil?
      @open_shard_count
    end
  end
end
