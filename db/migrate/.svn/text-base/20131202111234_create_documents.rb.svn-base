class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :report_name
      t.string :author
      t.string :sponsoring_orgnization
      t.date :date_of_report
      t.text :key_findings
      t.text :key_recommendations
      t.text :keywords
      t.string :key_ages
      t.text :notes_on_mythodology
      t.string :target_population
      t.string :data_availablity
      t.integer :user_id

      t.timestamps
    end
  end
end
