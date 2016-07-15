class Event < ActiveRecord::Base
  # Associations
  belongs_to :team
  has_many :attendances
  has_many :users, through: :attendances

  # Named Scopes
  scope :within_week, lambda {where(:event_date => Time.now..1.week.from_now)}
  scope :within_month, lambda {where(:event_date => 1.week.from_now..1.month.from_now)}
  scope :next_month, lambda {where(:event_date => 1.month.from_now..2.months.from_now)}
  scope :after_2_months, lambda {where('event_date > ?', 2.months.from_now)}




end
