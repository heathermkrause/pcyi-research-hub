class ChangeDocumentDateOfReportToString < ActiveRecord::Migration
  def change
    remove_column :documents, :publication_date
    add_column :documents, :publication_date, :string
  end
end
