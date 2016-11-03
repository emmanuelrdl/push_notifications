class Token < ActiveRecord::Base

  belongs_to :user


  scope :filter_registration, -> (value) {
    if value == 'registered'
      where.not(user_id: nil)
    elsif value == 'not_registered'
      where(user_id: nil)
    end
  }

  scope :filter_vendor, -> (value) {
    where(vendor: value) unless value == 'all'
  }

  scope :filter_users_gender,  -> (value) {
    where(users: { gender: value }) unless value == 'all'
  }


  scope :filter_users_age, -> (value) {
    unless value == 'all'
      starting_bitrthdate = value.split(",").first.to_datetime
      ending_birthdate    = value.split(',').last.to_datetime
      where(users: { birthdate: ending_birthdate..starting_bitrthdate})
   end
  }

  scope :filter_language, -> (value) {
    where(language: value) unless value == 'all'
  }




end