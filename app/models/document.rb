# == Schema Information
#
# Table name: documents
#
#  id                     :integer          not null, primary key
#  report_name            :string(255)
#  author                 :string(255)
#  sponsoring_orgnization :string(255)
#  date_of_report         :date
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
#

class Document < ActiveRecord::Base

  searchkick

  #default_scope order('created_at DESC')
  attr_accessible :author, :data_availablity, :date_of_report, :key_ages, :key_recommendations, :keywords, :notes_on_mythodology, :report_name, :sponsoring_orgnization, :target_population, :user_id, :keyfindings_attributes, :keywords_attributes,:pdf,:pdf_url
  belongs_to :user
  has_many :keyfindings#,:dependent=>:destroy
  has_many :keywords#,:dependent=>:destroy

  def self.s3_config
    YAML.load(File.read("#{Rails.root}/config/s3.yml"))[Rails.env]    
  end

  accepts_nested_attributes_for :keyfindings, :allow_destroy => true
  accepts_nested_attributes_for :keywords, :allow_destroy => true

  self.per_page = 10
  has_attached_file :pdf,
                    :storage => :aws,
                    :s3_credentials => {
                      :access_key_id => self.s3_config['access_key_id'],
                      :secret_access_key => self.s3_config['secret_access_key']
                    },
                    :s3_bucket => self.s3_config['bucket'],             
                    :s3_permissions => :authenticated_read,
                    :s3_host_name => 's3-us-west-2.amazonaws.com',
                    :s3_host_alias => "s3-us-west-2.amazonaws.com/pcyidocs",
                    :s3_protocol => 'http',
                    :path => "pcyi_documents/:id/:filename",
                    :url => ":s3_domain_url" 

  validates_presence_of :key_ages, :report_name

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
    doc = create(:report_name => row[0], :author => row[1], :sponsoring_orgnization => row[2], :date_of_report => row[3], :key_recommendations => row[5], :key_ages => row[7], :notes_on_mythodology => row[8], :target_population => row[9], :data_availablity => row[10], :user_id => user_id)
    Keyword.create_keywords(row[6],doc.id) if !row[6].nil?
    Keyfinding.create!(:keyfinding_text => row[4], :document_id => doc.id) if !row[4].nil?
  end

end
