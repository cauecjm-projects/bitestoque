require 'rails_helper'
  
RSpec.describe Size, type: :model do

  context 'campos não preenchidos' do
    subject { build(:size, name: nil) }

    it 'dados inválidos' do
      should be_invalid
    end

    it 'nenhum dado gravado' do
      expect(Size.all.size).to eql(0)
    end
  end

  context 'compos preenchidos' do
    subject{ @size = create(:size) }

    it 'dados válidos' do
      should be_valid
    end

    it 'dados gravados corretamente' do
      expect(Size.last).to eql(@size)
    end
  end

end
