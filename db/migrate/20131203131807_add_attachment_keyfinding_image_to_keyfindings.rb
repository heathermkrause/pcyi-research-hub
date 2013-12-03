class AddAttachmentKeyfindingImageToKeyfindings < ActiveRecord::Migration
  def self.up
    change_table :keyfindings do |t|
      t.attachment :keyfinding_image
    end
  end

  def self.down
    drop_attached_file :keyfindings, :keyfinding_image
  end
end
