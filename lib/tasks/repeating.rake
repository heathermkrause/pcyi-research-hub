namespace :repeating do

  # Usage

  # WARNING: The initial import will delete Documents, Keyfindings & Keywords
  # For initial import, call from the command line: heroku run rake "repeating:import[pcyi_initial_import,empty_database]"

  # For ongoing import, set up a scheduled task in Heroku with the command: rake "repeating:import[pcyi_initial_import]"

  desc "Initial import from Google Drive"
  task :import, [:spreadsheet_name, :empty_database] => :environment do |t, args|

    if args[:empty_database].present? && args[:empty_database].eql?("empty_database")
      # Get a clean start by clearing the database
      Document.delete_all
      Keyfinding.delete_all
      Keyword.delete_all
    end

    spreadsheet_name = args[:spreadsheet_name]

    session = GoogleDrive.login(ENV['GOOGLE_DRIVE_LOGIN'], ENV['GOOGLE_DRIVE_PASSWORD'])
    ws = session.spreadsheet_by_title(spreadsheet_name).worksheets[0]

    # Loop through the spreadsheet importing records
    for row in 2..ws.num_rows

      # Ignore and rows which have already been reported (disabled in development environment)
      if Rails.env.development? || ws[row, 13].empty?

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

        # Set the tags
        if ws[row, 14].eql?("1")
          doc.tag_list.add(ENV['AGE_RANGE_1'])
        end

        if ws[row, 15].eql?("1")
          doc.tag_list.add(ENV['AGE_RANGE_2'])
        end

        if ws[row, 16].eql?("1")
          doc.tag_list.add(ENV['AGE_RANGE_3'])
        end

        begin
          doc.save!
        rescue Exception => e
          puts "Problem with row #{row}"
          puts e.message
        end

        # Keyfindings
        kf_text = ws[row, 6].lstrip.rstrip

        unless kf_text.empty?
          kf = Keyfinding.find_or_create_by_keyfinding_text(kf_text)
          doc.keyfindings << kf
        end

        # Keywords
        kw_text_field = ws[row, 8].lstrip.rstrip

        unless kw_text_field.empty?

          keywords = kw_text_field.split(",")

          keywords.each do |keyword_text|
            unless keyword_text.empty?
              kw = Keyword.find_or_create_by_keyword_text(keyword_text.downcase)
              doc.keywords << kw
            end
          end
        end

        # Log the Datetime of row import
        ws[row, 13] = DateTime.now.to_s
        puts "#{doc.report_name} imported"

      end

      # Debugging
      #break if Rails.env.development?
    end
    ws.save()

    # Reindex search
    Document.reindex
  end

end