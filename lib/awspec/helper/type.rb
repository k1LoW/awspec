module Awspec
  module Helper
    module Type
      types = %w(
        base ec2 rds security_group vpc rds_db_parameters
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
