class CreateKeyfindings < ActiveRecord::Migration
  def change
    create_table :keyfindings do |t|
      t.integer :document_id
      t.text :keyfinding_text

      t.timestamps
    end
  end
end
