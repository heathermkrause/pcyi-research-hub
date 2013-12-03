class Document < ActiveRecord::Base
  attr_accessible :author, :data_availablity, :date_of_report, :key_ages, :key_recommendations, :keywords, :notes_on_mythodology, :report_name, :sponsoring_orgnization, :target_population, :user_id, :keyfindings_attributes
  belongs_to :user
  has_many :keyfindings
  has_many :keywords
  accepts_nested_attributes_for :keyfindings

  def self.dump(row,excel_id)
    doc = new(:report_name => row[0], :author => row[1], :sponsoring_orgnization => row[2], :date_of_report => row[3], :key_recommendations => row[5], :key_ages => row[7], :notes_on_mythodology => row[8], :target_population => row[9], :data_availablity => row[10])
   	result = doc.save
   	Keyword.create_keywords(row[6],doc.id) if !row[6].nil? && result
  	Keyfinding.create(:keyfinding_text => row[4], :document_id => doc.id) if !row[4].nil? && result
  end

end
