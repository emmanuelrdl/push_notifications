class RpushNotificationsCreator


  def self.create_rpush_notifications(push_campaign)

    tokens = Token.all
    create_rpush_apple_notifications(tokens, push_campaign)

  end


  def self.create_rpush_apple_notifications(tokens,  push_campaign)
    tokens.each do |token|
     ApplePush.create(token.push_token, push_campaign)
    end
  end


  # def create_rpush_android_notifications(token, alert, data)
  #   AndroidPush.create(token, alert, data)
  # end


end