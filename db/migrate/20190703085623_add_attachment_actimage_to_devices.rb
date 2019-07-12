class AddAttachmentActimageToDevices < ActiveRecord::Migration[5.2]
  def self.up
    change_table :devices do |t|
      t.attachment :actimage
    end
  end

  def self.down
    remove_attachment :devices, :actimage
  end
end
