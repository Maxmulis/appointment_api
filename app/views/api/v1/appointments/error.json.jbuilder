if @appointment
  json.errors(@appointment.errors) do |error|
    json.details error.type
    json.status @status
  end
end
