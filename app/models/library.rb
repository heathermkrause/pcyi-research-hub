class Library < ActiveRecord::Base

  attr_accessible :image

  has_attached_file :image,
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
    :path => "pcyi_images/:id/:filename",
    :url => ":s3_domain_url" 

    validates_presence_of :image

end
