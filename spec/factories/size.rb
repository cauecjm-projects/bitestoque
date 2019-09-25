FactoryBot.define do

  factory :size do
    name        { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
  end

end

