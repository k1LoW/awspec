module Awspec::Type
  class Rds < Base
    attr_reader :client, :instance

    def initialize(id)
      @client = Aws::RDS::Client.new
      super(id)
      # db_instance_identifier
      res = @client.describe_db_instances({
                                            db_instance_identifier: @id
                                          })
      @id = res[:db_instances][0][:db_instance_identifier]
      @instance = res[:db_instances][0]
    end

    states = %w(
      available backing-up creating deleting
      failed inaccessible-encryption-credentials
      incompatible-credentials incompatible-network
      incompatible-option-group incompatible-parameters
      incompatible-restore maintenance
      modifying rebooting renaming resetting-master-credentials
      restore-error storage-full upgrading
    )

    states.each do |state|
      define_method state + '?' do
        @instance[:db_instance_status] == state
      end
    end

    describes = %w(
      db_instance_identifier db_instance_class engine db_instance_status
      master_username db_name endpoint allocated_storage instance_create_time
      preferred_backup_window backup_retention_period db_security_groups
      vpc_security_groups db_parameter_groups availability_zone
      db_subnet_group preferred_maintenance_window pending_modified_values
      latest_restorable_time multi_az engine_version auto_minor_version_upgrade
      read_replica_source_db_instance_identifier
      read_replica_db_instance_identifiers license_model iops
      option_group_memberships character_set_name secondary_availability_zone
      publicly_accessible status_infos storage_type tde_credential_arn
      storage_encrypted kms_key_id dbi_resource_id ca_certificate_identifier
    )

    describes.each do |describe|
      define_method describe do
        @instance[describe]
      end
    end

    def vpc_id
      @instance[:db_subnet_group][:vpc_id]
    end

    def has_security_group?(sg_id)
      return true if has_vpc_security_group_id?(sg_id)
      return true if has_vpc_security_group_name?(sg_id)
      return true if has_vpc_security_group_tag_name?(sg_id)
      return true if has_db_security_group_name?(sg_id)
    end

    def has_db_parameter_group?(name)
      pgs = @instance[:db_parameter_groups]
      pgs.find do |pg|
        pg[:db_parameter_group_name] == name
      end
    end

    def has_option_group?(name)
      ogs = @instance[:option_group_memberships]
      ogs.find do |og|
        og[:option_group_name] == name
      end
    end

    private

    def has_vpc_security_group_id?(sg_id)
      sgs = @instance[:vpc_security_groups]
      sgs.find do |sg|
        sg[:vpc_security_group_id] == sg_id
      end
    end

    def has_vpc_security_group_name?(sg_id)
      sgs = @instance[:vpc_security_groups]
      res = @ec2_client.describe_security_groups({
                                                   filters: [{ name: 'group-name', values: [sg_id] }]
                                                 })
      return false unless res[:security_groups].count == 1
      sgs.find do |sg|
        sg[:vpc_security_group_id] == res[:security_groups][0][:group_id]
      end
    end

    def has_vpc_security_group_tag_name?(sg_id)
      sgs = @instance[:vpc_security_groups]
      res = @ec2_client.describe_security_groups({
                                                   filters: [{ name: 'tag:Name', values: [sg_id] }]
                                                 })
      return false unless res[:security_groups].count == 1
      sgs.find do |sg|
        sg[:vpc_security_group_id] == res[:security_groups][0][:group_id]
      end
    end

    def has_db_security_group_name?(sg_id)
      sgs = @instance[:db_security_groups]
      sgs.find do |sg|
        sg[:db_security_group_name] == sg_id
      end
    end
  end
end
