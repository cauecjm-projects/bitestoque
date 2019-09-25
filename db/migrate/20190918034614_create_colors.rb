class CreateColors < ActiveRecord::Migration[5.2]

  def change
    create_table :colors, option: 'ENGIEN=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci' do |t|
      t.string :name, limit: 20, null: false
      t.string :code, limit: 10, null: false

      t.index :name
    end
  end

end
