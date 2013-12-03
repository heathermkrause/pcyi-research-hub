class RemoveKeywordsFromDocument < ActiveRecord::Migration
  def up
    remove_column :documents, :keywords
  end

  def down
    add_column :documents, :keywords, :text
  end
end
