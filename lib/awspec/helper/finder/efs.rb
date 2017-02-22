module Awspec::Helper
  module Finder
    module Efs
      def find_efs(id)
        begin
          res = efs_client.describe_file_systems({
                                                   file_system_id: id,
                                                   max_items: 1
                                                 })
        rescue
          # Aws::EFS::Errors::BadRequest (invalid file system ID: my-efs)
          file_system_id = get_id_by_name_tag(id)
          res = efs_client.describe_file_systems({
                                                   file_system_id: file_system_id,
                                                   max_items: 1
                                                 })
        end
        res.file_systems.single_resource(id)
      end

      def find_efs_tags(id, tag_key)
        begin
          tag_set = efs_client.describe_tags({ file_system_id: id })
        rescue
          # Aws::EFS::Errors::BadRequest (invalid file system ID: my-efs)
          file_system_id = get_id_by_name_tag(id)
          tag_set = efs_client.describe_tags({
                                               file_system_id: file_system_id
                                             })
        end
        tag_query = tag_set.tags.find { |tag| tag.key == tag_key }
        return tag_query if tag_query
      end

      def get_id_by_name_tag(name)
        # takes a name tag and iterates inventory and returns file_system obj
        inventory = efs_client.describe_file_systems
        file_systems = inventory.file_systems.select do |fs|
          tag_query = efs_client.describe_tags({
                                                 file_system_id: fs.file_system_id
                                               })
          name_tag = tag_query.tags.find { |tag| tag.key == 'Name' } if tag_query.tags
          name_tag && name_tag.value == name
        end
        file_systems.single_resource(name).file_system_id
      end

      def get_name_by_id(id)
        tag_query = efs_client.describe_tags({
                                               file_system_id: id
                                             })
        name_tag = tag_query.tags.find { |tag| tag.key == 'Name' }
        return name_tag.value if name_tag
      end

      def select_all_file_systems
        file_systems_query = efs_client.describe_file_systems
        file_systems = file_systems_query.file_systems
        file_systems
      end
    end
  end
end
