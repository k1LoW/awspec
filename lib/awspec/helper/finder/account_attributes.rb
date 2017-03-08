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
            if value =~ /\A\d+\z/
              attributes[attr[:attribute_name].tr('-', '_').to_sym] = value.to_i
            else
              attributes[attr[:attribute_name].tr('-', '_').to_sym] = value
            end
          end
        end
        attributes.to_struct
      end

      def find_ses_send_quota
        ses_client.get_send_quota
      end
    end
  end
end
