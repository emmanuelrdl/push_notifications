class AndroidPush
  def self.create(token, data, delivery_at, id)
    notification = Rpush::Gcm::Notification.new(push_campaign_id: id)
    notification.app = Rpush::Gcm::App.find_by_name("android")
    notification.registration_ids = [token.push_token]
    notification.data = data
    notification.save!
    notification.deliver_after = delivery_at
  end
end
