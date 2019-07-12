class AddBrandToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :brand, :boolean
  end
end
