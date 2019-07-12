class CreateRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :requirements do |t|
      t.text :wishes
      t.integer :level
      t.integer :amount
      t.integer :price
      t.string :link
      t.string :for_what
      t.boolean :done
      t.boolean :got
      t.references :filial, foreign_key: true

      t.timestamps
    end
  end
end
