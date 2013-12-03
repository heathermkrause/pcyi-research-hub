class AddAttachmentExcelsheetFileToExcelsheets < ActiveRecord::Migration
  def self.up
    change_table :excelsheets do |t|
      t.attachment :excelsheet_file
    end
  end

  def self.down
    drop_attached_file :excelsheets, :excelsheet_file
  end
end
