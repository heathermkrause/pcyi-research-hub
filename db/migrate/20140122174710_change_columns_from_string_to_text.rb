class ChangeColumnsFromStringToText < ActiveRecord::Migration
  def up
    change_column :documents, :target_population, :text
    change_column :documents, :data_availablity, :text
  end

  def down
    # This might cause trouble if you have strings longer than 255 characters
    change_column :documents, :target_population, :string
    change_column :documents, :data_availablity, :string
  end
end
