class ApplePush

  def self.create(token, message, data, delivery_at, expire_at, push_campaign)
    notification = Rpush::Apns::Notification.new(push_campaign_id: push_campaign.id)
    notification.app = Rpush::Apns::App.find_by_name("ios")
    notification.device_token = token.push_token
    notification.alert = message
    notification.fail_after = DateTime.now + 10.hours
=begin
    notification.priority = 1
=end
    notification.data = {screen: data}
    notification.deliver_after = delivery_at
    notification.save!
  end


end
