class User < ActiveRecord::Base
  serialize :settings, JSON
  has_many :tokens


end
