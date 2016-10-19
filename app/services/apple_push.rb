class ApplePush
  def self.create!(app, device_token, alert, data)
    notification              = Rpush::Apns::Notification.new
    notification.app          = app
    notification.device_token = device_token
    notification.alert        = alert
    notification.data         = data
    notification.save!
  end


  def self.create
    n = Rpush::Apns::Notification.new
    n.app = Rpush::Apns::App.find_by_name("sherif-ios")
    n.device_token = "ad36784568c935de277e65093b4953cf796966c32b3ca832ad8551474a9be0a3"
    n.alert = "hi mom!"
    n.data = { foo: :bar }
    n.save!
  end


end
