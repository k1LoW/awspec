module Awspec::Helper
  module Finder
    module Acm
      def find_certificate(domain)
        cert = acm_client.list_certificates.certificate_summary_list.find { |c| c[:domain_name] == domain }
        acm_client.describe_certificate({ certificate_arn: cert.certificate_arn }).certificate
      end
    end
  end
end
