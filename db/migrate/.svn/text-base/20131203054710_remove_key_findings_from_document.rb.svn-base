class RemoveKeyFindingsFromDocument < ActiveRecord::Migration
  def up
    remove_column :documents, :key_findings
  end

  def down
    add_column :documents, :key_findings, :text
  end
end
