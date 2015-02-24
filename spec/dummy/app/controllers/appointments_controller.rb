class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(params.require(:appointment).permit(:scheduled_at))
    @appointment.save
    redirect_to root_url
  end
end
