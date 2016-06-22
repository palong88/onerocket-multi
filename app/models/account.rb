class Account < ActiveRecord::Base
  has_many :stakeholders
  validates :email, presence: true
end
