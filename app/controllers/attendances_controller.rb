class AttendancesController < ApplicationController


  def edit
    @attendance = Attendance.find(params[:id])
    @event = Event.where(id: @attendance.event_id).first
  end



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
    @attendance = Attendance.find(params[:id])

    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to user_eadmin_tasks_path(:id => @attendance.user_id), notice: 'RSVP Submitted!' }
        # format.json { render :show, status: :ok, location: @eadmin_task }
      else
        format.html { redirect_to edit_eadmin_task_path(:id => @attendance.user_id), notice: 'Task was not created.'}
        # format.json { render json: @eadmin_task.errors, status: :unprocessable_entity }
      end
    end
  end



  def destroy
  end

  private

  def set_event
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:user_id, :event_id, :rsvp, :id)
  end

end
