class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.string :mark
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
