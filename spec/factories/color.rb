FactoryBot.define do

  factory :color do
    name { FFaker::Lorem.word }
    code { FFaker::Color.hex_code }
  end

end

