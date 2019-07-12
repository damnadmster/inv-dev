class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :model
      t.string :invnum
      t.string :serial
      t.datetime :dateprod
      t.string :proc
      t.string :ram
      t.string :place
      t.string :mark
      t.boolean :cancellation
      t.references :type, foreign_key: true
      t.references :filial, foreign_key: true

      t.timestamps
    end
  end
end
