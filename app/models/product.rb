class Product < ApplicationRecord

  has_many :available_products
  has_many :colors, through: :available_products
  has_many :sizes,  through: :available_products

  validates_presence_of :name, lenght: { minimum: 3, maximum: 100, message: 'O nome deve ter entre 3 e 100 caracteres.' }

end
