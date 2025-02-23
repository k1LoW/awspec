# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module Wafv2
      def find_ip_set(scope, name)
        ip_sets = select_all_ip_sets(scope)
        ip_set  = ip_sets.find do |i|
          i.name == name
        end
        return false unless ip_set

        get_ip_set(scope, name, ip_set.id)
      end

      def select_all_ip_sets(scope)
        res = wafv2_client.list_ip_sets({ scope: scope })
        res.ip_sets
      end

      def get_ip_set(scope, name, id)
        res = wafv2_client.get_ip_set({ name: name, scope: scope, id: id })
        res.ip_set
      end

      def find_web_acl(scope, name)
        web_acls = select_all_web_acls(scope)
        web_acl = web_acls.find do |acl|
          acl.name == name
        end
        return false unless web_acl

        get_web_acl(scope, name, web_acl.id)
      end

      def select_all_web_acls(scope)
        res = wafv2_client.list_web_acls({ scope: scope })
        res.web_acls
      end

      def get_web_acl(scope, name, id)
        res = wafv2_client.get_web_acl({ name: name, scope: scope, id: id })
        res.web_acl
      end
    end
  end
end
