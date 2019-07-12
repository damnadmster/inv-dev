class AddAttachmentAvatarToDevices < ActiveRecord::Migration[5.2]
  def self.up
    change_table :devices do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :devices, :avatar
  end
end
