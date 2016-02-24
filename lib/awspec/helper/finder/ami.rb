module Awspec::Helper
  module Finder
    module Ami
      def find_ami(image_id)
        res = ec2_client.describe_images({
                                           filters: [{ name: 'image-id', values: [image_id] }]
                                         })
        if res[:images].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{image_id}"
        end
        return res[:images].first if res[:images].count == 1
        res = ec2_client.describe_images({
                                           filters: [{ name: 'name', values: [image_id] }]
                                         })
        if res[:images].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{image_id}"
        end
        return res[:images].first if res[:images].count == 1
        res = ec2_client.describe_images({
                                           filters: [{ name: 'tag:Name', values: [image_id] }]
                                         })
        if res[:images].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{image_id}"
        end
        res[:images].first if res[:images].count == 1
      end
    end
  end
end
