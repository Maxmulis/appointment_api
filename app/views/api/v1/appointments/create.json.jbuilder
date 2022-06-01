json.lat @appointment.latitude
json.lng @appointment.longitude
json.address @appointment.address
json.time @appointment.strftime

json.seller do
  json.name @appointment.name
  json.phone @appointment.phone
end

json.realtor do
  json.name @realtor.name
  json.city @realtor.city
end

unless @appointment.valid?
  json.errors(@appointment.errors) do |error|
    json.details error.type
  end
end
