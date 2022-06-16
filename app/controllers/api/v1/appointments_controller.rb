class Api::V1::AppointmentsController < ApplicationController
  before_action :set_default_format
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :bad_request
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from NoMethodError, with: :bad_request

  def create
    appointment = Appointment.new(appointment_params)
    realtor = Realtor.closest_to([appointment.lat, appointment.lng])
    appointment.realtor = realtor
    appointment.save!
    render json: appointment, include: :realtor, status: :created
  end

  private

  def set_default_format
    request.format = :json
  end

  def appointment_params
    params.require(:appointment).permit(:lat, :lng, :address, :time, seller: {})
  end
end
