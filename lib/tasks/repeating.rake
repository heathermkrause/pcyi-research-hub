namespace :repeating do

  desc "Initial import from Google Drive"
  task :initial_import, [:spreadsheet_name] => :environment do |t, args|

    # Start by clearing the existing database
    Document.delete_all
    Keyfinding.delete_all
    Keyword.delete_all

    spreadsheet_name = args[:spreadsheet_name]

    session = GoogleDrive.login(ENV['GOOGLE_DRIVE_LOGIN'], ENV['GOOGLE_DRIVE_PASSWORD'])
    ws = session.spreadsheet_by_title(spreadsheet_name).worksheets[0]

    # Loop through the spreadsheet importing records
    for row in 2..ws.num_rows

      doc = Document.new
      doc.report_name = ws[row, 1]
      doc.link = ws[row, 2]
      doc.author = ws[row, 3]
      doc.sponsoring_orgnization = ws[row, 4]
      doc.date_of_report = ws[row, 5]
      doc.key_recommendations = ws[row, 7]
      doc.key_ages = ws[row, 9]
      doc.notes_on_mythodology = ws[row, 10]
      doc.target_population = ws[row, 11]
      doc.data_availablity = ws[row, 12]

      begin
        doc.save!
      rescue Exception => e
        puts "Problem with row #{row}"
        puts e.message
      end

      # Keyfindings

      # Keywords

      #break if Rails.env.development?
    end

  end

end