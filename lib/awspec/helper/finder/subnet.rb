require 'singleton'

module Awspec::Helper
  module Finder
    module Subnet
      # Implements in-memory cache for +AWS::Ec2::Client+ +describe_subnets+
      # method.

      # == Usage
      # Includes {Singleton}[https://ruby-doc.org/stdlib-2.7.3/libdoc/singleton/rdoc/index.html]
      # module, so use +instance+ instead of +new+ to get a instance.
      #
      # It is intended to be used internally by the +find_subnet+ function only.
      #
      # Many of the methods expect a symbol to search through the cache to
      # avoid having to call +to_sym+ multiple times.

      class SubnetCache
        include Singleton

        def initialize # :nodoc:
          @by_tag_name = {}
          @by_cidr = {}
          @subnet_ids = {}
          @ip_matcher = Regexp.new('^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/\d{1,2}$')
        end

        # Add a mapping of a CIDR to the respective subnet ID
        def add_by_cidr(cidr, subnet_id)
          key_sym = cidr.to_sym
          @by_cidr[key_sym] = subnet_id.to_sym unless @by_cidr.key?(key_sym)
        end

        # Add a mapping of a tag to the respective subnet ID
        def add_by_tag(tag, subnet_id)
          key_sym = tag.to_sym
          @by_tag_name[key_sym] = subnet_id.to_sym unless @by_tag_name.key?(key_sym)
        end

        # Add a +Aws::EC2::Types::Subnet+ instance to the cache, mapping it's ID
        # to the instance itself.
        def add_subnet(subnet)
          key_sym = subnet.subnet_id.to_sym
          @subnet_ids[key_sym] = subnet unless @subnet_ids.key?(key_sym)
        end

        # Check if a subnet ID (as a symbol) exists in the cache.
        def has_subnet?(subnet_id_symbol)
          @subnet_ids.key?(subnet_id_symbol)
        end

        # Return a +Aws::EC2::Types::Subnet+ that matches the given CIDR.
        def subnet_by_cidr(cidr_symbol)
          @subnet_ids[@by_cidr[cidr_symbol]]
        end

        # Return a +Aws::EC2::Types::Subnet+ that matches the given tag.
        def subnet_by_tag(tag_symbol)
          @subnet_ids[@by_tag_name[tag_symbol]]
        end

        # Return a +Aws::EC2::Types::Subnet+ that matches the given subnet ID.
        def subnet_by_id(subnet_id_symbol)
          @subnet_ids[subnet_id_symbol]
        end

        # Check if a given string looks like a IPv4 CIDR.
        def is_cidr?(subnet_id)
          @ip_matcher.match(subnet_id)
        end

        # Check if the cache was already initialized or not.
        def empty?
          @subnet_ids.empty?
        end

        # Return the cache as a string.
        def to_s
          "by tag name: #{@by_tag_name}, by CIDR: #{@by_cidr}"
        end
      end

      # Try to locate a +Aws::EC2::Types::Subnet+ with a given subnet ID.
      #
      # A subnet ID might be multiple things, like the
      # +Aws::EC2::Types::Subnet.subnet_id+, or a IPv4 CIDR or the value for the
      # +Name+ tag associated with the subnet.
      #
      # Returns a instance of +Aws::EC2::Types::Subnet+ or +nil+.
      def find_subnet(subnet_id)
        cache = SubnetCache.instance

        if cache.empty?
          res = ec2_client.describe_subnets

          res.subnets.each do |sub|
            cache.add_by_cidr(sub.cidr_block, sub.subnet_id)
            cache.add_subnet(sub)
            next if sub.tags.empty?

            sub.tags.each do |tag|
              if tag[:key].eql?('Name')
                cache.add_by_tag(tag[:value], sub.subnet_id)
                break
              end
            end
          end
        end

        id_key = subnet_id.to_sym
        return cache.subnet_by_id(id_key) if subnet_id.start_with?('subnet-') && cache.has_subnet?(id_key)
        return cache.subnet_by_cidr(id_key) if cache.is_cidr?(subnet_id) && cache.by_cidr.key?(id_key)
        cache.subnet_by_tag(id_key)
      end
    end

    # Search for the subnets associated with a given VPC ID.
    #
    # Returns an array of +Aws::EC2::Types::Subnet+ instances.
    def select_subnet_by_vpc_id(vpc_id)
      res = ec2_client.describe_subnets({
                                          filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                        })
      res.subnets
    end
  end
end
