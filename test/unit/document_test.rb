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

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
