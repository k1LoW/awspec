module Awspec::Helper
  module Finder
    module Acm
      def find_certificate(id)
        selected = []
        req = {}
        loop do
          res = acm_client.list_certificates(req)
          selected += res.certificate_summary_list.select do |c|
            c.certificate_arn == id || c.domain_name == id
          end
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end

        cert = selected.single_resource(id)
        acm_client.describe_certificate({ certificate_arn: cert.certificate_arn }).certificate
      end

      def select_all_certificates
        certs = []
        req = {}
        loop do
          res = acm_client.list_certificates(req)
          res.certificate_summary_list.each do |c|
            certs << c.certificate_arn
          end
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end

        certificates = []
        certs.each do |cert|
          certificates << acm_client.describe_certificate({ certificate_arn: cert }).certificate
        end
        certificates
      end
    end
  end
end
