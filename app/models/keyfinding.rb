# == Schema Information
#
# Table name: keyfindings
#
#  id                            :integer          not null, primary key
#  document_id                   :integer
#  keyfinding_text               :text
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  keyfinding_image_file_name    :string(255)
#  keyfinding_image_content_type :string(255)
#  keyfinding_image_file_size    :integer
#  keyfinding_image_updated_at   :datetime
#

class Keyfinding < ActiveRecord::Base
  attr_accessible :document_id, :keyfinding_text,:keyfinding_image
  belongs_to :document

  validates_format_of :keyfinding_image, :with => %r{\.(png|jpg|jpeg)$}i, :message => "Please select image format png,jpg or jpeg."
  has_attached_file :keyfinding_image,
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
                    :path => "pcyi_documents/:id/keyfinding_images/:filename",
                    :url => ":s3_domain_url" 


end
