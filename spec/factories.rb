FactoryBot.define do
  factory :appointment do
    latitude { 52.5019145 }
    longitude { 13.4135005 }
    address { 'Prinzessinnenstraße 26, 10969 Berlin' }
    name { 'Alexander Schmitt' }
    phone { '+498005800550' }
    time { '02/12/2021 10:00' }
  end
end
