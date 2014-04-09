# == Schema Information
#
# Table name: excelsheets
#
#  id                           :integer          not null, primary key
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  excelsheet_file_file_name    :string(255)
#  excelsheet_file_content_type :string(255)
#  excelsheet_file_file_size    :integer
#  excelsheet_file_updated_at   :datetime
#  user_id                      :integer
#

class Excelsheet < ActiveRecord::Base
  attr_accessible :id, :excelsheet_file
  belongs_to :user

  validates_format_of :excelsheet_file, :with => %r{\.(xls|xlsx)$}i, :message => "Please select xls or xlsx file."
  has_attached_file :excelsheet_file,
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
