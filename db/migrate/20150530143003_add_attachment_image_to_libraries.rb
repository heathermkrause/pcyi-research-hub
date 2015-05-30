class AddAttachmentImageToLibraries < ActiveRecord::Migration
  def self.up
    change_table :libraries do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :libraries, :image
  end
end
