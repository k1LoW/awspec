module Awspec::Helper
  module Finder
    module Ec2
      def find_ec2(id)
        if id.is_a?(Array)
          # Aws::EC2::Client.describe_instances native filters format
          res = @client.describe_instances({
                                             filters: id
                                           })
        elsif id.is_a?(Hash)
          # syntax sugar
          filters = []
          id.each do |k, v|
            filters.push({ name: k, values: Array(v) })
          end
          res = @client.describe_instances({
                                             filters: filters
                                           })
        else
          # instance_id or tag:Name
          begin
            res = @client.describe_instances({
                                               instance_ids: [id]
                                             })
          rescue
            # Aws::EC2::Errors::InvalidInstanceIDMalformed
            # Aws::EC2::Errors::InvalidInstanceIDNotFound
            res = @client.describe_instances({
                                               filters: [{ name: 'tag:Name', values: [id] }]
                                             })
          end
        end
        return res[:reservations][0][:instances][0] if res[:reservations][0][:instances].count == 1
      end
    end
  end
end
