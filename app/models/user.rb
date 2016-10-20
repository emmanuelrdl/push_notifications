class User < ActiveRecord::Base


  scope :filter_gender,  -> (value) {
    where(gender: value) if value
  }

  scope :filter_age, -> (value) {
    where(birthdate: value..Date.today) if value
  }

=begin
  scope :filter_vendor, -> (value) {

  }
=end


end
