class Event < ActiveRecord::Base
  belongs_to :team
  has_many :attendances
  has_many :users, through: :attendances

end
