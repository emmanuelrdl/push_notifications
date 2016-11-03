class RpushNotificationsCreator
  # other action is to send push to one specific user

  def self.create_rpush_notifications(push_campaign)
    tokens = Token.includes(:user).filter_registration(push_campaign.target_registration_state).filter_vendor(push_campaign.vendor)

    tokens = tokens.filter_users_gender(push_campaign.target_users_gender).filter_users_age(push_campaign.target_users_age) if push_campaign.target_registration_state == 'registered'
    create_rpush_apple_notifications(tokens.where(vendor: 'ios'), push_campaign) if tokens.where(vendor: 'ios').count > 0
    create_rpush_android_notifications(tokens.where(vendor: 'android'), push_campaign) if tokens.where(vendor: 'android').count > 0
  end

  def self.create_user_notification(token, message, data)
    if token.vendor == 'ios'
      ApplePush.create(token, message, nil, nil, nil, nil)
    elsif token.vendor == 'android'
      AndroidPush.create(token, { message: message, data: data }, nil, nil)
    end
  end


  def self.create_rpush_apple_notifications(tokens,  push_campaign)
    tokens.each do |token|
      ApplePush.create(token, push_campaign.message, push_campaign.data, push_campaign.delivery_at, push_campaign.expire_at, push_campaign.id)
    end
  end


   def self.create_rpush_android_notifications(tokens, push_campaign)
     tokens.each do |token|
        AndroidPush.create(token, { message: push_campaign.message, data:  push_campaign.data }, push_campaign.delivery_at, push_campaign.id)
     end
   end



end