class AndroidPush
  def self.create!(app, registration_ids, data)
    notification                  = Rpush::Gcm::Notification.new
    notification.app              = app
    notification.registration_ids = registration_ids
    notification.data             = data
    notification.save!
  end
end
