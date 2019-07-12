class AddTypeosToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :typeos, :string
  end
end
