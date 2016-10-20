class ApplePush
=begin
  def self.create!(app, device_token, alert, data)
    notification              = Rpush::Apns::Notification.new
    notification.app          = app
    notification.device_token = device_token
    notification.alert        = alert
    notification.data         = data
    notification.save!
  end
=end


  def self.create(token, push_campaign)
    notification = Rpush::Apns::Notification.new
    notification.app = Rpush::Apns::App.find_by_name("ios")
    notification.device_token = token
    notification.alert = push_campaign.message
    notification.data = push_campaign.data
    notification.save!
  end


end
