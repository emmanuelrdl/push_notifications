class AndroidPush
  def self.create(token, data)
    notification = Rpush::Gcm::Notification.new
    notification.app = Rpush::Gcm::App.find_by_name("android")
    notification.registration_ids = [token]
    notification.data = data
    notification.save!
  end
end
