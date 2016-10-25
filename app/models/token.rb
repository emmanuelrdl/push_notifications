class Token < ActiveRecord::Base

  belongs_to :user


  scope :filter_registration, -> (value) {
    if value == 'registered'
      where.not(user_id: nil)
    elsif value == 'not_registered'
      where(user_id: nil)
    end
  }

  # Check how to move this logic to User controller

  scope :filter_users_gender,  -> (value) {
    where(users: { gender: value }) if value.present?
  }

  scope :filter_vendor, -> (value) {
    where(vendor: value) if value.present?
  }

  scope :filter_users_age, -> (value) {
    if value.present?
      starting_bitrthdate = value.split(",").first.to_datetime
      ending_birthdate    = value.split(',').last.to_datetime
      where(users: { birthdate: ending_birthdate..starting_bitrthdate})
   end
  }



end