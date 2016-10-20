class RpushNotificationsCreator


  def self.create_rpush_notifications(push_campaign)

    tokens = Token.filter_gender(push_campaign.target_gender).filter_age(push_campaign.target_age).filter_vendor(push_campaign.vendor).filter_registration(push_campaign.registered_users)
    create_rpush_apple_notifications(tokens, push_campaign)

  end

=begin
  * Version de l'app iOS (à récupérer depuis les données existantes)
  * Version de l'app Android (à récupérer depuis les données existantes)
  * Features activés -> Multisélection
=end


  def self.create_rpush_apple_notifications(tokens,  push_campaign)
    tokens.each do |token|
      ApplePush.create(token.push_token, push_campaign)
    end
  end


   def self.create_rpush_android_notifications(tokens, push_campaign)
     tokens.each do |token|
        AndroidPush.create(token, push_campaign)
     end
   end


end