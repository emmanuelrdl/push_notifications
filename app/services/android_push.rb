class AndroidPush
  def self.create(token, data, push_campaign)
    notification = Rpush::Gcm::Notification.new(push_campaign_id: push_campaign.id)
    notification.app = Rpush::Gcm::App.find_by_name("android")
    notification.registration_ids = [token]
    notification.data = data
    notification.save!
    notification.deliver_after = push_campaign.delivery_at
  end
end
