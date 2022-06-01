json.lat @appointment.latitude
json.lng @appointment.longitude
json.address @appointment.address
json.time @appointment.strftime

json.seller do
  json.name @appointment.name
  json.phone @appointment.phone
end

json.realtor do
  json.name @appointment.realtor.name
  json.city @appointment.realtor.city
end
