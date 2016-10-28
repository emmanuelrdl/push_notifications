class ApplePush

  def self.create(token, message, data, delivery_at, expire_at, id)
    notification = Rpush::Apns::Notification.new(push_campaign_id: id)
    notification.app = Rpush::Apns::App.find_by_name("ios")
    notification.device_token = token.push_token
    notification.alert = message
    notification.data = {screen: data}
    notification.deliver_after = delivery_at
    notification.fail_after = expire_at
    notification.save!
  end


end
