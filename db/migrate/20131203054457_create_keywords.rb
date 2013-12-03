class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.integer :document_id
      t.string :keyword_text

      t.timestamps
    end
  end
end
