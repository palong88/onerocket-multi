class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def invite_employee(employees, event)
    # add event for each employee id
    employees.each do |e|
      Attendance.create(user_id: e.id, event_id: event, rsvp: "Invited")
    end
  end

  private

end
