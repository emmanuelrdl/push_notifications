class ApplePush

  def self.create(token, push_campaign)
    notification = Rpush::Apns::Notification.new(push_campaign_id: push_campaign.id)
    notification.app = Rpush::Apns::App.find_by_name("ios")
    notification.device_token = token
    notification.alert = push_campaign.message
    notification.data = push_campaign.data
    notification.deliver_after = push_campaign.delivery_at
    notification.fail_after = push_campaign.expire_at
    notification.save!
  end


end
