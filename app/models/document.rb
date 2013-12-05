class Document < ActiveRecord::Base
  attr_accessible :author, :data_availablity, :date_of_report, :key_ages, :key_recommendations, :keywords, :notes_on_mythodology, :report_name, :sponsoring_orgnization, :target_population, :user_id, :keyfindings_attributes, :keywords_attributes
  belongs_to :user
  has_many :keyfindings,:dependent=>:destroy
  has_many :keywords,:dependent=>:destroy
  
  accepts_nested_attributes_for :keyfindings
  accepts_nested_attributes_for :keywords

  self.per_page = 10

  validates_presence_of :key_ages, :report_name

  validates_length_of :report_name, :maximum => 60, :message=> "less than 60 if you don't mind"

  validates_length_of :report_name, :maximum => 200, :message=> "less than 60 if you don't mind"
  validates_length_of :author, :maximum => 50, :message => "less than 60 if you don't mind"
  validates_length_of :data_availablity, :maximum => 50, :message => "less than 60 if you don't mind"
  validates_length_of :key_ages, :maximum => 50, :message => "less than 60 if you don't mind"
  validates_length_of :key_recommendations, :maximum => 50, :message => "less than 60 if you don't mind"
  validates_length_of :notes_on_mythodology, :maximum => 50, :message => "less than 60 if you don't mind"
  validates_length_of :report_name, :maximum => 50, :message => "less than 60 if you don't mind"
  validates_length_of :sponsoring_orgnization, :maximum => 50, :message => "less than 60 if you don't mind"
  validates_length_of :target_population, :maximum => 50, :message => "less than 60 if you don't mind"


  def self.dump(row,excel_id,user_id)
  	begin
      Date.parse(row[3])
    rescue
      row[3] = nil
    end
    puts "creating doc"
    f = new(:report_name => row[0], :author => row[1], :sponsoring_orgnization => row[2], :date_of_report => row[3], :key_recommendations => row[5], :key_ages => row[7], :notes_on_mythodology => row[8], :target_population => row[9], :data_availablity => row[10], :user_id => user_id)
    puts "valid doc? "+f.errors.full_messages
    f.save
    doc = f
    puts "created doc with "+ doc.id.to_s
    Keyword.create_keywords(row[6],doc.id) if !row[6].nil?
    puts "creating finding"
  	Keyfinding.create!(:keyfinding_text => row[4], :document_id => doc.id) if !row[4].nil?
    puts "finding created"
  end

end
