require 'rails_helper'
  
RSpec.describe Color, type: :model do

  context 'campos não preenchidos' do
    subject { build(:color, name: nil, code: nil) }

    it 'dados inválidos' do
      should be_invalid
    end

    it 'nenhum dado gravado' do
      expect(Color.all.size).to eql(0)
    end
  end

  context 'compos preenchidos' do
    subject{ @color = create(:color) }

    it 'dados válidos' do
      should be_valid
    end

    it 'dados gravados corretamente' do
      expect(Color.last).to eql(@color)
    end
  end

end
