module Awspec::Helper
  module Finder
    module Directconnect
      def find_virtual_interface(virtual_interface_id)
        res = directconnect_client.describe_virtual_interfaces
        ret = res.virtual_interfaces.select do |virtual_interface|
          next true if virtual_interface.virtual_interface_id == virtual_interface_id
          next true if virtual_interface.virtual_interface_name == virtual_interface_id
        end
        ret.single_resource(virtual_interface_id)
      end

      def select_virtual_interfaces
        res = directconnect_client.describe_virtual_interfaces
        res.virtual_interfaces
      end
    end
  end
end
