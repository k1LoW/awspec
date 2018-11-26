module Awspec::Type
  class Sqs < ResourceBase
    def resource_via_client
      return @resource_via_client if @resource_via_client
      queue_url = id
      attributes = {}
      res = sqs_client.get_queue_attributes({
                                              queue_url: queue_url,
                                              attribute_names: ['All']
                                            })
      res.attributes.each do |key, value|
        attributes[key.underscore] = value
      end
      attributes['queue_url'] = queue_url
      @resource_via_client ||= attributes
    end

    def id
      @id ||= find_queue(@display_name)
    end

    def method_missing(name)
      param_name = name.to_s
      if resource_via_client.include?(param_name)
        resource_via_client[param_name]
      else
        super
      end
    end

    def has_tag?(tag_key, tag_value)
      @tag_set ||= find_tags_for_queue(@id)
      return nil if @tag_set[tag_key] != tag_value
      true
    end
  end
end
