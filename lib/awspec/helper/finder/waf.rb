module Awspec::Helper
  module Finder
    module Waf
      def find_waf_web_acl(id)
        finded = nil
        next_marker = nil

        loop do
          res = waf_client.list_web_acls(next_marker: next_marker, limit: 100)
          finded = res.web_acls.find do |acl|
            acl.web_acl_id == id || acl.name == id
          end
          (finded.nil? && next_marker = res.next_marker) || break
        end

        return nil unless finded
        waf_client.get_web_acl(web_acl_id: finded.web_acl_id).web_acl
      end

      def find_waf_rule(id)
        finded = nil
        next_marker = nil

        loop do
          res = waf_client.list_rules(next_marker: next_marker, limit: 1)
          finded = res.rules.find do |rule|
            rule.rule_id == id || rule.name == id
          end
          (finded.nil? && next_marker = res.next_marker) || break
        end

        return nil unless finded
        waf_client.get_rule(rule_id: finded.rule_id).rule
      end

      def find_waf_ip_set(id)
        finded = nil
        next_marker = nil

        loop do
          res = waf_client.list_ip_sets(next_marker: next_marker, limit: 1)
          finded = res.ip_sets.find do |set|
            set.ip_set_id == id || set.name == id
          end
          (finded.nil? && next_marker = res.next_marker) || break
        end

        return nil unless finded
        waf_client.get_ip_set(ip_set_id: finded.ip_set_id).ip_set
      end
    end
  end
end
