class AddRepairToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :repair, :boolean
  end
end
