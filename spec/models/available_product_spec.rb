require 'rails_helper'

RSpec.describe AvailableProduct, type: :model do

  context 'campos não preenchidos' do
    subject { build(:available_product, qtd: nil, product: nil, color: nil, size: nil ) }

    context 'dados inválidos' do
      it { should be_invalid }
    end

    context 'nenhum dado gravado' do 
      it { expect(AvailableProduct.all.size).to eql(0) }
      it { expect(Product.all.size).to          eql(0) }
      it { expect(Color.all.size).to            eql(0) }
      it { expect(Size.all.size).to             eql(0) }
    end
  end

  context 'compos preenchidos' do
    before { @ava_prod = create(:available_product) }

    context 'dados válidos' do
      it { expect(@ava_prod.valid?).to be true }
    end

    context 'dados gravados corretamente' do
      it { expect(AvailableProduct.last).to eql(@ava_prod) }
      it { expect(Product.last).to          eql(@ava_prod.product) }
      it { expect(Color.last).to            eql(@ava_prod.color) }
      it { expect(Size.last).to             eql(@ava_prod.size) }
    end
  end

end
