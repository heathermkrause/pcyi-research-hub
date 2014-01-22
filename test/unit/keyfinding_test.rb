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

require 'test_helper'

class KeyfindingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
