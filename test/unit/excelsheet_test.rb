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

require 'test_helper'

class ExcelsheetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
