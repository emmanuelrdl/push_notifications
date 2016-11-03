class PushNotification < ActiveRecord::Base
  self.table_name = 'rpush_notifications'
  attr_accessor  :fr_message



end