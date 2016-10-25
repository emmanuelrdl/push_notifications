class RpushNotificationsCreator
  # other action is to send push to one specific user

  def self.create_rpush_notifications(push_campaign)

    tokens = Token.includes(:user).filter_registration(push_campaign.target_users).filter_vendor(push_campaign.vendor).filter_users_gender(push_campaign.target_gender)
    tokens = tokens.filter_users_age(push_campaign.target_age).filter_app_version(push_campaign.ios_app_version)
    if tokens.where(vendor: 'ios').count > 0
      create_rpush_apple_notifications(tokens.where(vendor: 'ios'), push_campaign)
    elsif tokens.where(vendor: 'android').count > 0
      create_rpush_android_notifications(tokens.where(vendor: 'android'), push_campaign)
    end
  end

=begin
  $ data page
  * Features activés -> Multisélection
=end

  # Add mongo db for settings

  def self.create_rpush_apple_notifications(tokens,  push_campaign)
    tokens.each do |token|
      ApplePush.create(token.push_token, push_campaign)
    end
  end


   def self.create_rpush_android_notifications(tokens, push_campaign)
     tokens.each do |token|
        AndroidPush.create(token.push_token, {message: push_campaign.message, data: push_campaign.data})
     end
   end


end