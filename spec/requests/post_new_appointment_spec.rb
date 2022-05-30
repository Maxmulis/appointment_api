require 'rails_helper'

RSpec.describe 'Appointments', type: :request do
  describe 'POST /create' do
    let(:appointment) { build :appointment }
    context 'with valid parameters' do
      before do
        post '/api/v1/appointments', params:
                          { appointment: {
                            lat: appointment.latitude,
                            lng: appointment.longitude,
                            address: appointment.address,
                            time: '02/12/2021 10:00',
                            seller:
                              {
                                name: appointment.name,
                                phone: appointment.phone
                              }
                          } }
      end

      it 'returns all data passed in the request' do
        expect(json['lat']).to eq(appointment.latitude)
        expect(json['lng']).to eq(appointment.longitude)
        expect(json['address']).to eq(appointment.address)
        expect(json['time']).to eq(appointment.time)
        expect(json['seller']['name']).to eq(appointment.name)
        expect(json['seller']['phone']).to eq(appointment.phone)
      end

      it 'returns name and city of the assigned realtor' do
        expect(json['realtor']['name']).to eq('Zelma Hammersley')
        expect(json['realtor']['city']).to eq('Berlin')
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/appointments', params:
                          { appointment: {
                          } }
      end

      it 'returns a bad request status' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'outside of working hours' do
      before do
        post '/api/v1/appointments', params:
                          { appointment: {
                            lat: appointment.latitude,
                            lng: appointment.longitude,
                            address: appointment.address,
                            time: '30/05/2022 18:30',
                            seller:
                              {
                                name: appointment.name,
                                phone: appointment.phone
                              }
                          } }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
