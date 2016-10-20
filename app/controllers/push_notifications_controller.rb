class PushNotificationsController < ApplicationController



    def create

      n = Rpush::Apns::Notification.new
      n.app = Rpush::Apns::App.find_by_name("ios")
      n.device_token = "ad36784568c935de277e65093b4953cf796966c32b3ca832ad8551474a9be0a3"
      n.alert = "hi mom!"
      n.data = { foo: :bar }
      n.save!
      Rpush.push
      render nothing: true, status: 200
    end






end