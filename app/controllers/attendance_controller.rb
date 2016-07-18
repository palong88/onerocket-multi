class AttendanceController < ApplicationController

  def create
    ap 'Success'
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to manage_event_attendance_path(:id => @attendance.event_id), notice: 'Employee was successfully invited.' }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

  end

  def destroy
  end

  private

  def set_event
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:user_id, :event_id, :rsvp)
  end

end
