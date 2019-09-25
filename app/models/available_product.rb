class AvailableProduct < ApplicationRecord

  belongs_to :product
  belongs_to :color
  belongs_to :size

  validates_associated :product, :color, :size

  validates_presence_of :qtd, numericality: { only_integer: true, message: 'A quantidade deve ser igual ou maior que zero.' }

end
