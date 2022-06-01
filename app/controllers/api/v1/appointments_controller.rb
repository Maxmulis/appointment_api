class Api::V1::AppointmentsController < ApplicationController
  before_action :set_default_format
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :bad_request
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

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
    @appointment.save!
    render status: :created
  end

  private

  def set_default_format
    request.format = :json
  end

  def appointment_params
    params.require(:appointment).permit(:lat, :lng, :address, :time, seller: {})
  end
end
