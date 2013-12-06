class Excelsheet < ActiveRecord::Base
  attr_accessible :id, :excelsheet_file
  belongs_to :user
  def self.s3_config
    YAML.load(File.read("#{Rails.root}/config/s3.yml"))[Rails.env]    
  end

  validates_format_of :excelsheet_file, :with => %r{\.(xls|xlsx)$}i, :message => "Please select xls or xlsx file."
  has_attached_file :excelsheet_file,
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

  #validates_format_of :excelsheet_file, :with => %r{\.(xls|xlsx)$}i

  after_save :dump_to_table

  def dump_to_table
     require 'roo'
     file = self.excelsheet_file.to_file
     extension = File.extname(file.path)
     excel_file(file, extension).each_with_index { |row,index|
        next if (index == 0)
        puts "dumping doc"
        Document.dump(row,id, self.user.id)
     }

  end

  def excel_file(file, extension)
  	case extension
      when '.xls' then Roo::Excel.new(file.path)
      when '.xlsx' then Roo::Excelx.new(file.path) 
    end
  end

end
