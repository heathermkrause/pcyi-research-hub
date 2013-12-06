class Keyword < ActiveRecord::Base
  attr_accessible :document_id, :keyword_text
  belongs_to :document

  #validates_presence_of :keyword_text
  #validates_length_of :keyword_text, :maximum => 200, :message => "less than 50 if you don't mind"
  
  def self.create_keywords(keywords,doc_id)
  	separate_keywords = keywords.split(",")
  	puts "created keyword"
  	create!(separate_keywords.map{|key| {:keyword_text => key, :document_id => doc_id}})
  end
  
end
