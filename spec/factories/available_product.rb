FactoryBot.define do
  
  factory :available_product do
    qtd { rand(100) }

    product
    color
    size
  end

end
