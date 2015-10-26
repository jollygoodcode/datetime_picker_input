class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(params.require(:appointment).permit(:scheduled_at))
    if @appointment.save
      redirect_to edit_appointment_path(@appointment), notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(params.require(:appointment).permit(:scheduled_at))
      redirect_to edit_appointment_path(@appointment), notice: "Appointment was successfully updated."
    else
      render :edit
    end
  end
end
