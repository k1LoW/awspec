module Awspec::Type
  class LaunchTemplateVersion < ResourceBase
    def resource_via_client
      display_name = @display_name.split(':')
      if display_name[1].nil? || display_name[1] == 'default'
        begin
          display_name[1] = find_launch_template(display_name[0]).default_version_number
        rescue
          display_name[1] = 1
        end
      elsif display_name[1] == 'latest'
        display_name[1] = find_launch_template(display_name[0]).latest_version_number
      end
      @resource_via_client ||= find_launch_template_version(display_name[0], display_name[1])
    end

    def id
      @id ||= resource_via_client.launch_template_id if resource_via_client
    end
  end
end
