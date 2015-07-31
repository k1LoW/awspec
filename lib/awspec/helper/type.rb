module Awspec
  module Helper
    module Type
      types = %w(
        base ec2 rds rds_db_parameter_group security_group
        vpc s3 route53_hosted_zone
      )

      types.each { |type| require "awspec/type/#{type}" }

      types.each do |type|
        define_method type do |*args|
          name = args.first
          eval "Awspec::Type::#{type.to_camel_case}.new(name)"
        end
      end
    end
  end
end
