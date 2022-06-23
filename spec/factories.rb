FactoryBot.define do
  factory :appointment do
    lat { 52.5019145 }
    lng { 13.4135005 }
    address { 'Prinzessinnenstraße 26, 10969 Berlin' }
    name { 'Alexander Schmitt' }
    phone { '+498005800550' }
    time { Date.current }
  end
end
