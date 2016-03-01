module Awspec::Helper
  module Finder
    module Ami
      def find_ami(image_id)
        res = ec2_client.describe_images({
                                           filters: [{ name: 'image-id', values: [image_id] }]
                                         })
        resource = res.images.single_resource(image_id)
        return resource if resource
        res = ec2_client.describe_images({
                                           filters: [{ name: 'name', values: [image_id] }]
                                         })
        resource = res.images.single_resource(image_id)
        return resource if resource
        res = ec2_client.describe_images({
                                           filters: [{ name: 'tag:Name', values: [image_id] }]
                                         })
        res.images.single_resource(image_id)
      end
    end
  end
end
