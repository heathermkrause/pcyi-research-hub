# == Schema Information
#
# Table name: keywords
#
#  id           :integer          not null, primary key
#  document_id  :integer
#  keyword_text :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class KeywordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
