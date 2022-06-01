class Api::V1::AppointmentsController < ApplicationController
  def create
    @appointment = Appointment.new(
      latitude: appointment_params[:lat],
      longitude: appointment_params[:lng],
      address: appointment_params[:address],
      time: appointment_params[:time],
      name: appointment_params[:seller][:name],
      phone: appointment_params[:seller][:phone],
    )
    @realtor = Realtor.closest_to([@appointment.latitude, @appointment.longitude])
    @appointment.realtor = @realtor
    render status: :created
  end

  private

  def appointment_params
    params.require(:appointment).permit(:lat, :lng, :address, :time, seller: {})
  end
end
