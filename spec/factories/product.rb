FactoryBot.define do

  factory :product do
    name        { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
  end

end

