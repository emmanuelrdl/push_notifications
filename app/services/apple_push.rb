class ApplePush

  def self.create(token, push_campaign)
    notification = Rpush::Apns::Notification.new
    notification.app = Rpush::Apns::App.find_by_name("ios")
    notification.device_token = token
    notification.alert = push_campaign.message
    notification.data = push_campaign.data
    notification.save!
  end


end
