class PushCampaignsController < ApplicationController

  def index
    @push_campaigns = PushCampaign.all
  end

  def new
    @push_campaign = PushCampaign.new()
  end


  def create
    @push_campaign = PushCampaign.create(push_campaign_params)
    redirect_to push_campaigns_path
  end


  # ios: expiration_date
  # android:  time_to_live
  # collapse_key
  # Issue Features enabled - multi select
  # Check push length
  # Check push path
  # Remarque : Si aucun critère de sélection n'est déterminé, avant d'envoyer le push indiquer avec une alerte : "Attention, votre push sera envoyé à l'intégralité des utilisateurs, voulez-vous continuer". -> OUI : Envoyer le push, NON : Rester sur la page


 def push_campaign_params
   params.require(:push_campaign).permit(:name, :message, :target_age, :target_gender, :vendor, :language, :registered_users, :ios_app_version, :android_app_version, :expire_at, :time_to_live, :delivery_at )
 end


 def find_push_campaign
   @push_campaign = PushCampaign.find(params[:id])
 end




end