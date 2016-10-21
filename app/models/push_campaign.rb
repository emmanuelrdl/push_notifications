class PushCampaign < ActiveRecord::Base

  attr_accessor :page
  serialize :data

  SCREENS_TO_DISPLAY = [['Home', 1], ['Média Audio',2], ['Média Vidéo',3] , [' Média Photos' , 4], ['Settings', 5] , ['Profile', 6], ['Achat bouton', 7] , ['Achat SMS' , 8], ['Achat Appels', 9]]

  TARGET_AGE_GROUPS = [['< 18',       "#{Date.today}, #{Date.today - 17.years}"],
                       ['>=18 & <26', "#{Date.today - 18.years}, #{Date.today - 25.years}"],
                       ['>=26 & <35', "#{Date.today - 26.years}, #{Date.today - 34.years}"],
                       ['>=35 & <45', "#{Date.today - 35.years}, #{Date.today - 44.years}"],
                       ['>=45 & <55', "#{Date.today - 44.years}, #{Date.today - 54.years}"],
                       ['>=55 & <65', "#{Date.today - 55.years}, #{Date.today - 64.years}"],
                       ['>=65',       "#{Date.today - 65.years}, #{Date.today - 100.years}"]]

  VENDORS = ['ios', 'android']

  LANGUAGES = ['FR']

  TARGET_GENDERS = ['male', 'female']

  TARGET_USERS = ['registered', 'not_registered']

  before_validation :format_target_age_group
  before_save :set_time_to_live, :set_data
  after_save  :create_notifications


  def set_time_to_live
    self.time_to_live = 10000
  end

  def set_data
    self.data = {screen: self.page}
  end

  def format_target_age_group
    self.target_age.split("..") if self.target_age
  end


  def create_notifications
    RpushNotificationsCreator.create_rpush_notifications(self)
  end



end
