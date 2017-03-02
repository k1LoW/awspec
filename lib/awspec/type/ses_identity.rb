module Awspec::Type
  class SesIdentity < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_ses_identity(@display_name)
    end

    def id
      @id ||= resource_via_client if resource_via_client
    end

    def has_identity_policy?(name)
      res = ses_client.list_identity_policies({
                                                identity: id
                                              })
      res.policy_names.find do |policy_name|
        policy_name == name
      end
    end

    # dkim_attributes
    dkim_attributes = %w(
      dkim_enabled dkim_verification_status
    )

    dkim_attributes.each do |attribute|
      define_method attribute do
        res = ses_client.get_identity_dkim_attributes({
                                                        identities: [id]
                                                      })
        res.dkim_attributes[id][attribute.to_sym]
      end
    end

    def has_dkim_tokens?(token)
      res = ses_client.get_identity_dkim_attributes({
                                                      identities: [id]
                                                    })
      res.dkim_attributes[id][:tokens].include?(token)
    end

    # notification_attributes
    notification_attributes = %w(
      bounce_topic complaint_topic delivery_topic
      forwarding_enabled
    )

    notification_attributes.each do |attribute|
      define_method attribute do
        res = ses_client.get_identity_notification_attributes({
                                                                identities: [id]
                                                              })
        res.notification_attributes[id][attribute.to_sym]
      end
    end

    # verification_attributes
    verification_attributes = %w(
      verification_status verification_token
    )

    verification_attributes.each do |attribute|
      define_method attribute do
        res = ses_client.get_identity_verification_attributes({
                                                                identities: [id]
                                                              })
        res.verification_attributes[id][attribute.to_sym]
      end
    end
  end
end
