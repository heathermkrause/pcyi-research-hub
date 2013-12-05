class Keyfinding < ActiveRecord::Base
  attr_accessible :document_id, :keyfinding_text,:keyfinding_image
  belongs_to :document

  def self.s3_config
    YAML.load(File.read("#{Rails.root}/config/s3.yml"))[Rails.env]    
  end

  validates_format_of :keyfinding_image, :with => %r{\.(png|jpg|jpeg)$}i, :message => "Please select image format png,jpg or jpeg."

  has_attached_file :keyfinding_image,
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
                    :path => "pcyi_documents/:id/keyfinding_images/:filename",
                    :url => ":s3_domain_url" 


end
