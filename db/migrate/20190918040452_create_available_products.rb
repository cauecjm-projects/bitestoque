class CreateAvailableProducts < ActiveRecord::Migration[5.2]

  def change
    create_table :available_products, option: 'ENGIEN=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci' do |t|
      t.integer :qtd, unsigned: true, null: false

      t.references :product, foreign_key: true, index: true, null: false
      t.references :color,   foreign_key: true, index: true, null: false
      t.references :size,    foreign_key: true, index: true, null: false

      t.index :qtd
    end
  end

end
