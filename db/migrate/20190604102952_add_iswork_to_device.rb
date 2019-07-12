class AddIsworkToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :iswork, :boolean
  end
end
