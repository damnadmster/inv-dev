class AddClearactToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :clearact, :boolean
  end
end
