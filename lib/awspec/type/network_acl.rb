module Awspec::Type
  class NetworkAcl < ResourceBase
    aws_resource Aws::EC2::NetworkAcl
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_network_acl(@display_name)
    end

    def id
      @id ||= resource_via_client.network_acl_id if resource_via_client
    end

    def has_subnet?(subnet_id)
      resource_via_client.associations.find do |a|
        next true if a.subnet_id == subnet_id
        subnet = find_subnet(subnet_id)
        next false unless subnet
        next a.subnet_id == subnet.subnet_id
      end
    end

    def allowed?(port = nil, protocol = nil, cidr = nil, rule_number = nil)
      rule_action = 'allow'
      entry?(rule_action, port, protocol, cidr, rule_number)
    end

    def denied?(port = nil, protocol = nil, cidr = nil, rule_number = nil)
      rule_action = 'deny'
      entry?(rule_action, port, protocol, cidr, rule_number)
    end

    def inbound
      @egress = false
      self
    end

    def outbound
      @egress = true
      self
    end

    def inbound_entries_count
      resource_via_client.entries.count do |entry|
        entry.egress == false
      end
    end

    def outbound_entries_count
      resource_via_client.entries.count do |entry|
        entry.egress == true
      end
    end

    # rubocop:disable Metrics/LineLength
    PROTOCOLS = { 'ALL' => -1, 'HOPOPT' => 0, 'ICMP' => 1, 'IGMP' => 2, 'GGP' => 3, 'IPv4' => 4, 'ST' => 5, 'TCP' => 6, 'CBT' => 7, 'EGP' => 8, 'IGP' => 9, 'BBN-RCC-MON' => 10,
                  'NVP-II' => 11, 'PUP' => 12, 'ARGUS' => 13, 'EMCON' => 14, 'XNET' => 15, 'CHAOS' => 16, 'UDP' => 17, 'MUX' => 18, 'DCN-MEAS' => 19, 'HMP' => 20,
                  'PRM' => 21, 'XNS-IDP' => 22, 'TRUNK-1' => 23, 'TRUNK-2' => 24, 'LEAF-1' => 25, 'LEAF-2' => 26, 'RDP' => 27, 'IRTP' => 28, 'ISO-TP4' => 29, 'NETBLT' => 30,
                  'MFE-NSP' => 31, 'MERIT-INP' => 32, 'DCCP' => 33, '3PC' => 34, 'IDPR' => 35, 'XTP' => 36, 'DDP' => 37, 'IDPR-CMTP' => 38, 'TP++' => 39, 'IL' => 40,
                  'IPv6' => 41, 'SDRP' => 42, 'IPv6-Route' => 43, 'IPv6-Frag' => 44, 'IDRP' => 45, 'RSVP' => 46, 'GRE' => 47, 'DSR' => 48, 'BNA' => 49, 'ESP' => 50,
                  'AH' => 51, 'I-NLSP' => 52, 'SWIPE' => 53, 'NARP' => 54, 'MOBILE' => 55, 'TLSP' => 56, 'IPv6-ICMP' => 58, 'IPv6-NoNxt' => 59, 'IPv6-Opts' => 60,
                  '61' => 61, 'CFTP' => 62, '63' => 63, 'SAT-EXPAK' => 64, 'KRYPTOLAN' => 65, 'RVD' => 66, 'IPPC' => 67, '68' => 68, 'SAT-MON' => 69, 'VISA' => 70,
                  'IPCV' => 71, 'CPNX' => 72, 'CPHB' => 73, 'WSN' => 74, 'PVP' => 75, 'BR-SAT-MON' => 76, 'SUN-ND' => 77, 'WB-MON' => 78, 'WB-EXPAK' => 79, 'ISO-IP' => 80,
                  'VMTP' => 81, 'SECURE-VMTP' => 82, 'VINES' => 83, 'IPTM' => 84, 'TTP' => 84, 'NSFNET-IGP' => 85, 'DGP' => 86, 'TCF' => 87, 'EIGRP' => 88, 'OSPFIGP' => 89, 'Sprite-RPC' => 90,
                  'LARP' => 91, 'MTP' => 92, 'AX.25' => 93, 'IPIP' => 94, 'MICP' => 95, 'SCC-SP' => 96, 'ETHERIP' => 97, 'ENCAP' => 98, '99' => 99, 'GMTP' => 100,
                  'IFMP' => 101, 'PNNI' => 102, 'PIM' => 103, 'ARIS' => 104, 'SCPS' => 105, 'QNX' => 106, 'A/N' => 107, 'IPComp' => 108, 'SNP' => 109, 'Compaq-Peer' => 110,
                  'IPX-in-IP' => 111, 'VRRP' => 112, 'PGM' => 113, '114' => 114, 'L2TP' => 115, 'DDX' => 116, 'IATP' => 117, 'STP' => 118, 'SRP' => 119, 'UTI' => 120,
                  'SMP' => 121, 'SM' => 122, 'PTP' => 123, 'ISIS over IPv4' => 124, 'FIRE' => 125, 'CRTP' => 126, 'CRUDP' => 127, 'SSCOPMCE' => 128, 'IPLT' => 129, 'SPS' => 130,
                  'PIPE' => 131, 'SCTP' => 132, 'FC' => 133, 'RSVP-E2E-IGNORE' => 134, 'Mobility Header' => 135, 'UDPLite' => 136, 'MPLS-in-IP' => 137, 'manet' => 138, 'HIP' => 139, 'Shim6' => 140,
                  'WESP' => 141, 'ROHC' => 142, '253' => 253, '254' => 254 }
    # rubocop:enable Metrics/LineLength

    private

    def entry?(rule_action, port = nil, protocol = nil, cidr = nil, rule_number = nil)
      resource_via_client.entries.find do |entry|
        # egress rule_action
        next false if entry.egress != @egress
        next false if entry.rule_action != rule_action
        # protocol
        unless protocol.nil?
          next false unless protocol_match?(protocol, entry.protocol)
        end
        # cidr
        next false if !cidr.nil? && entry.cidr_block != cidr
        # rule_number
        rule_number = 32_767 if rule_number == '*'
        next false if !rule_number.nil? && entry.rule_number != rule_number
        # port
        unless entry.port_range.nil?
          next false unless port_between?(port, entry.port_range.from, entry.port_range.to)
        end
        next true
      end
    end

    def protocol_match?(a, b)
      if a.match(/\A\d+\z/) && a.to_i >= 0
        return false unless b.to_i == a.to_i
      else
        lower_h = PROTOCOLS.map { |k, v| [k.downcase, v] }.to_h
        return false unless lower_h.key?(a.downcase)
        return false unless b.to_i == lower_h[a.downcase]
      end
      true
    end

    def port_between?(port, from_port, to_port)
      if port.is_a?(String) && port.include?('-')
        f, t = port.split('-')
        from_port == f.to_i && to_port == t.to_i
      else
        port.between?(from_port, to_port)
      end
    end
  end
end
