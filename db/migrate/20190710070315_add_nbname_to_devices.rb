class AddNbnameToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :nbname, :string
  end
end
