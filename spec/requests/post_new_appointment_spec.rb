require 'rails_helper'

RSpec.describe 'Appointments', type: :request do
  describe 'POST /create' do
    let(:appointment) { build :appointment }
    before(:all) do
      @headers = { "ACCEPT" => "application/json" }
    end
    context 'with valid parameters' do
      before do
        post '/api/v1/appointments', headers: @headers, params:
                          { "appointment": {
                            "lat": appointment.latitude,
                            "lng": appointment.longitude,
                            "address": appointment.address,
                            "time": appointment.time.sunday.noon + 3,
                            "seller":
                              {
                                "name": appointment.name,
                                "phone": appointment.phone
                              }
                          } }
      end

      it 'returns all data passed in the request' do
        expect(json["lat"]).to eq(appointment.latitude)
        expect(json["lng"]).to eq(appointment.longitude)
        expect(json["address"]).to eq(appointment.address)
        expect(json["time"]).to eq((appointment.time.sunday.noon + 3).strftime("%d/%m/%Y %H:%M"))
        expect(json["seller"]["name"]).to eq(appointment.name)
        expect(json["seller"]["phone"]).to eq(appointment.phone)
      end

      it 'returns name and city of the assigned realtor' do
        expect(json['realtor']['name'].length).to be > 0
        expect(json['realtor']['city'].length).to be > 0
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/appointments', headers: @headers, params:
                          { "appointment": {
                          } }
      end

      it 'returns a bad request status' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'outside of working hours' do
      before do
        post '/api/v1/appointments', headers: @headers, params:
                          { "appointment": {
                            "lat": appointment.latitude,
                            "lng": appointment.longitude,
                            "address": appointment.address,
                            "time": "30/05/2022 18:30",
                            "seller":
                              {
                                "name": appointment.name,
                                "phone": appointment.phone
                              }
                          } }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'on Sunday' do
      before do
        post '/api/v1/appointments', headers: @headers, params:
                          { "appointment": {
                            "lat": appointment.latitude,
                            "lng": appointment.longitude,
                            "address": appointment.address,
                            "time": appointment.time.sunday.noon,
                            "seller":
                              {
                                "name": appointment.name,
                                "phone": appointment.phone
                              }
                          } }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'less than 48 hours in the future' do
      before do
        post '/api/v1/appointments', headers: @headers, params:
                          { "appointment": {
                            "lat": appointment.latitude,
                            "lng": appointment.longitude,
                            "address": appointment.address,
                            "time": appointment.time.next_weekday.noon, # assures that date is neither on a weekend nor during work hours
                            "seller":
                              {
                                "name": appointment.name,
                                "phone": appointment.phone
                              }
                          } }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end
end
