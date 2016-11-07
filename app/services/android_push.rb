class AndroidPush
  def self.create(token, data, delivery_at, push_campaign)
    notification = Rpush::Gcm::Notification.new(push_campaign_id: push_campaign.id)
    notification.app = Rpush::Gcm::App.find_by_name("android")
    notification.registration_ids = [token.push_token]
    notification.data = data
    notification.deliver_after = delivery_at
    notification.expiry = (push_campaign.expire_at - Time.now > 0) ? (push_campaign.expire_at - Time.now) : 0
    notification.save!
  end
end



