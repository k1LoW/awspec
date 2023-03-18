# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module AccountAttributes
      def find_ec2_account_attributes
        attributes = {}
        ec2_client.describe_account_attributes.account_attributes.each do |attr|
          values = attr[:attribute_values].map do |v|
            v[:attribute_value]
          end
          if attr[:attribute_name] == 'supported-platforms'
            # supported-platforms
            attributes[attr[:attribute_name].tr('-', '_').to_sym] = values
          else
            value = values.first
            attributes[attr[:attribute_name].tr('-', '_').to_sym] = if value =~ /\A\d+\z/
                                                                      value.to_i
                                                                    else
                                                                      value
                                                                    end
          end
        end
        attributes.to_struct
      end

      def find_rds_account_attributes
        attributes = {}
        rds_client.describe_account_attributes.account_quotas.each do |attr|
          values = {
            used: attr[:used],
            max: attr[:max]
          }
          attributes[attr[:account_quota_name].to_sym] = values.to_struct
        end
        attributes.to_struct
      end

      def find_lambda_account_settings
        attributes = {}
        settings = lambda_client.get_account_settings
        settings.account_limit.members.each do |key|
          attributes[key] = { limit: settings.account_limit[key] }
        end
        settings.account_usage.members.each do |key|
          if attributes.include?(key)
            attributes[key][:usage] = settings.account_usage[key]
          else
            attributes[key] = { usage: settings.account_usage[key] }
          end
        end
        attributes.to_struct
      end

      def find_ses_send_quota
        ses_client.get_send_quota
      rescue StandardError
        # Aws::Errors::NoSuchEndpointError
        nil
      end
    end
  end
end
