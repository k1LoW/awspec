require 'singleton'

module Awspec::Helper
  module Finder
    module Subnet
      class SubnetCache
        include Singleton
        attr_reader :by_tag_name, :by_cidr

        def initialize
          @by_tag_name = {}
          @by_cidr = {}
          @subnet_ids = {}
          @ip_matcher = Regexp.new('^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/\d{1,2}$')
        end

        def add_by_cidr(cidr, subnet_id)
          key_sym = cidr.to_sym
          @by_cidr[key_sym] = subnet_id.to_sym unless @by_cidr.key?(key_sym)
        end

        def add_by_tag(tag, subnet_id)
          key_sym = tag.to_sym
          @by_tag_name[key_sym] = subnet_id.to_sym unless @by_tag_name.key?(key_sym)
        end

        def add_subnet(subnet)
          key_sym = subnet.subnet_id.to_sym
          @subnet_ids[key_sym] = subnet unless @subnet_ids.key?(key_sym)
        end

        def has_subnet?(subnet_id_symbol)
          @subnet_ids.key?(subnet_id_symbol)
        end

        def subnet_by_cidr(cidr_symbol)
          @subnet_ids[@by_cidr[cidr_symbol]]
        end

        def subnet_by_tag(tag_symbol)
          @subnet_ids[@by_tag_name[tag_symbol]]
        end

        def is_cidr?(subnet_id)
          @ip_matcher.match(subnet_id)
        end

        def empty?
          @subnet_ids.empty?
        end
      end

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
        return subnet(subnet_id) if subnet_id.start_with?('subnet-') && cache.has_subnet?(id_key)
        return subnet(cache.subnet_by_cidr(id_key)) if cache.is_cidr?(subnet_id) && cache.by_cidr.key?(id_key)
        subnet(cache.subnet_by_tag(id_key))
      end
    end

    def select_subnet_by_vpc_id(vpc_id)
      res = ec2_client.describe_subnets({
                                          filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                        })
      res.subnets
    end

    def subnet(subnet_id)
      res = ec2_client.describe_subnets({
                                          filters: [{ name: 'subnet-id', values: [subnet_id] }]
                                        })
      res.subnets.single_resource(subnet_id)
    end
  end
end
