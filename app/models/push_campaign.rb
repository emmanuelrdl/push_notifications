class PushCampaign < ActiveRecord::Base

  attr_accessor :page
  serialize :data

  SCREENS_TO_DISPLAY = [['Home', 1], ['Média Audio',2], ['Média Vidéo',3] , [' Média Photos' , 4], ['Settings', 5] , ['Profile', 6], ['Achat bouton', 7] , ['Achat SMS' , 8], ['Achat Appels', 9]]

  TARGET_AGE_GROUPS = ['>18', '>=18 & <26', '>=26 & <35', '>=35 & <45', '>=45 & <55', '>=55 & <65', '>=65']

  VENDORS = ['ios', 'android']

  LANGUAGES = ['FR']

  TARGET_GENDERS = ['male', 'female']

  TARGET_USERS = ['registered', 'not_registered']

  before_save :set_time_to_live, :set_data
  after_save  :create_notifications


  def set_time_to_live
    self.time_to_live = 10000
  end

  def set_data
    self.data = {screen: self.page}
  end


  def create_notifications
    RpushNotificationsCreator.create_rpush_notifications(self)
  end



end
