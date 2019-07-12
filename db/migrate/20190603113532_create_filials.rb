class CreateFilials < ActiveRecord::Migration[5.2]
  def change
    create_table :filials do |t|
      t.integer :num
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
