class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def invite_employee(email, event)
    # find employee_id by email
    # get event_id
    # create new attendance record, user_id, event_id, rsvp as "Invited"
  end
end
