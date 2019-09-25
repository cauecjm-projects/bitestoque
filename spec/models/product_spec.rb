require 'rails_helper'
  
RSpec.describe Product, type: :model do

  context 'campos não preenchidos' do
    subject { build(:product, name: nil) }

    it 'dados inválidos' do
      should be_invalid
    end

    it 'nenhum dado gravado' do
      expect(Product.all.size).to eql(0)
    end
  end

  context 'compos preenchidos' do
    subject{ @product = create(:product) }

    it 'dados válidos' do
      should be_valid
    end

    it 'dados gravados corretamente' do
      expect(Product.last).to eql(@product)
    end
  end

end
