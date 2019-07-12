class AddRigthsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :right, :integer, default: 0
    add_reference :users, :filial, foreign_key: true
  end
end
