class PushCampaignsController < ApplicationController



    def create


      Rpush.push
      render nothing: true, status: 200
    end






end