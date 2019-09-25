class Color < ApplicationRecord

  has_many :available_products
  has_many :products, through: :available_products
  has_many :sizes,    through: :available_products

  validates_presence_of :name, lenght: { in: (3..100), message: 'O nome deve ter entre 3 e 100 caracteres.' }
  validates_presence_of :code, lenght: { is: 7,        message: 'O código da cor deve ser como o exemplo: #f0f0f0' }

end
