class ApplicationController < ActionController::API
  private

  def bad_request
    status = 400
    render json: {
      errors:
      {
        details: "Malformatted JSON or value missing",
        status: status

      }
    }, status: status
  end

  def unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  def appointment_params
     p = params.require(:appointment).permit(:lat, :lng, :address, :time, seller: {})
     p.delete("seller")
     return p
  end

  def seller_params
    p = params.require(:appointment).permit(:lat, :lng, :address, :time, seller: {})
    return p["seller"]

  end

end
