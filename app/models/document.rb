# == Schema Information
#
# Table name: documents
#
#  id                     :integer          not null, primary key
#  report_name            :string(255)
#  author                 :string(255)
#  sponsoring_orgnization :string(255)
#  key_recommendations    :text
#  key_ages               :string(255)
#  notes_on_mythodology   :text
#  target_population      :text
#  data_availablity       :text
#  user_id                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  pdf_url                :string(255)
#  pdf_file_name          :string(255)
#  pdf_content_type       :string(255)
#  pdf_file_size          :integer
#  pdf_updated_at         :datetime
#  link                   :string(255)
#  publication_date       :string(255)
#

class Document < ActiveRecord::Base

  searchkick({:index_name => 'documents_production_20140824134454201'})
  acts_as_taggable

  def search_data
    {
      report_name: report_name,
      author: author,
      sponsoring_orgnization: sponsoring_orgnization,
      publication_date: publication_date,
      key_recommendations: key_recommendations,
      # key_ages: key_ages,
      notes_on_mythodology: notes_on_mythodology,
      target_population: target_population,
      data_availablity: data_availablity,
      keyfinding_text_field: keyfindings.map(&:keyfinding_text),
      keyword_text_field: keywords.map(&:keyword_text)
    }
  end

  #default_scope order('created_at DESC')
  attr_accessible :author, :data_availablity, :publication_date, :key_ages, :key_recommendations, :keywords, :notes_on_mythodology, :report_name, :sponsoring_orgnization, :target_population, :user_id, :keyfindings_attributes, :keywords_attributes,:pdf,:pdf_url

  #belongs_to :user

  has_many :keyfindings#,:dependent=>:destroy
  has_many :keywords#,:dependent=>:destroy

  def self.link_present
    where{link.matches("%http%")}
  end

  # Required for nested_form
  accepts_nested_attributes_for :keyfindings, :allow_destroy => true
  accepts_nested_attributes_for :keywords, :allow_destroy => true

  self.per_page = 10
  has_attached_file :pdf,
                    :storage => :aws,
                    :s3_credentials => {
                      :access_key_id => ENV['S3_ACCESS_KEY_ID'],
                      :secret_access_key => ENV['S3_SECRET_ACCESS_KEY']
                    },
                    :s3_bucket => ENV['S3_BUCKET'],
                    :s3_permissions => :authenticated_read,
                    :s3_host_name => 's3-us-west-2.amazonaws.com',
                    :s3_host_alias => "s3-us-west-2.amazonaws.com/pcyidocs",
                    :s3_protocol => 'http',
                    :path => "pcyi_documents/:id/:filename",
                    :url => ":s3_domain_url" 

  validates_presence_of :report_name

  #validates_length_of :report_name, :maximum => 150, :message=> "should be less than 150"
  #validates_length_of :author, :maximum => 100, :message => "should be than less than 100 "
  #validates_length_of :data_availablity, :maximum => 50, :message => "should be less than 50"
  #validates_length_of :key_ages, :maximum => 50, :message => "should be less than 50"
  #validates_length_of :key_recommendations, :maximum => 200, :message => "should be less than 200"
  #validates_length_of :notes_on_mythodology, :maximum => 200, :message => "should be less than 200"
  #validates_length_of :sponsoring_orgnization, :maximum => 100, :message => "should be less than 100"
  #validates_length_of :target_population, :maximum => 50, :message => "should be less than 50"
  #validates_format_of :pdf_url, :with =>  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,:if => lambda{ |object| object.pdf_url.present? }
  #validates_attachment :pdf, :content_type => { :content_type => "application/pdf" },:if => lambda{ |object| object.pdf.present? }


  def self.dump(row,excel_id,user_id)
    begin
      Date.parse(row[3])
    rescue
      row[3] = nil
    end 
    doc = create(:report_name => row[0], :author => row[1], :sponsoring_orgnization => row[2], :publication_date => row[3], :key_recommendations => row[5], :key_ages => row[7], :notes_on_mythodology => row[8], :target_population => row[9], :data_availablity => row[10], :user_id => user_id)
    Keyword.create_keywords(row[6],doc.id) if !row[6].nil?
    Keyfinding.create!(:keyfinding_text => row[4], :document_id => doc.id) if !row[4].nil?
  end

  def tag_names
    self.tags.collect{|tag| tag.name}
  end

end
