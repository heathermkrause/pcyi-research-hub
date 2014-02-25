class ChangeDocumentDateOfReportToString < ActiveRecord::Migration
  def change
    remove_column :documents, :date_of_report
    add_column :documents, :publication_date, :string
  end
end
