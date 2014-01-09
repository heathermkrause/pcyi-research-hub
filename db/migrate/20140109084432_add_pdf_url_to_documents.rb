class AddPdfUrlToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :pdf_url, :string
  end
end
