module Awspec::Type
  class SecurityGroup < Base
    attr_reader :client, :sg, :inbound

    def initialize(id)
      super
      @client = @ec2_client
      @inbound = true
      @sg = find_security_group(id)
      @id = @sg[:group_id] if @sg
    end

    def method_missing(name)
      describe = name.to_s
      if @sg.key?(describe)
        @sg[describe]
      else
        super
      end
    end

    def opened?(port = nil, protocol = nil, cidr = nil)
      if @inbound
        return inbound_opened?(port, protocol, cidr)
      else
        return outbound_opened?(port, protocol, cidr)
      end
    end

    def inbound_opened?(port = nil, protocol = nil, cidr = nil)
      @sg[:ip_permissions].find do |permission|
        next true unless port
        next true unless permission[:from_port]
        next true unless permission[:to_port]
        next false unless port.between?(permission[:from_port], permission[:to_port])
        next false if protocol && permission[:ip_protocol] != protocol
        next true unless cidr
        ret = permission[:ip_ranges].select do |ip_range|
          ip_range[:cidr_ip] == cidr
        end
        next true if ret.count > 0
        ret = permission[:user_id_group_pairs].select do |sg|
          next true if sg[:group_id] == cidr
          sg2 = find_security_group(sg[:group_id])
          next true if sg2[:group_name] == cidr
          sg2[:tags].find do |tag|
            tag[:key] == 'Name' && tag[:value] == cidr
          end
        end
        next true if ret.count > 0
      end
    end

    def outbound_opened?(port = nil, protocol = nil, cidr = nil)
      @sg[:ip_permissions_egress].find do |permission|
        next true unless port
        next true unless permission[:from_port]
        next true unless permission[:to_port]
        next false unless port.between?(permission[:from_port], permission[:to_port])
        next false if protocol && permission[:ip_protocol] != protocol
        next true unless cidr
        ret = permission[:ip_ranges].select do |ip_range|
          ip_range[:cidr_ip] == cidr
        end
        next true if ret.count > 0
        ret = permission[:user_id_group_pairs].select do |sg|
          next true if sg[:group_id] == cidr
          sg2 = find_security_group(sg[:group_id])
          next true if sg2[:group_name] == cidr
          sg2[:tags].find do |tag|
            tag[:key] == 'Name' && tag[:value] == cidr
          end
        end
        next true if ret.count > 0
      end
    end

    def inbound
      @inbound = true
      self
    end

    def outbound
      @inbound = false
      self
    end
  end
end
