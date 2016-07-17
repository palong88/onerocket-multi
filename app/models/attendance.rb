class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  # Invite each employee id passed in an array to the event of choice
  def invite_employee(employees, event)
    employees.each do |e|
      Attendance.create(user_id: e, event_id: event, rsvp: "Invited")
    end
  end

  private

end
