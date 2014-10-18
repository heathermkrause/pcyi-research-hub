namespace :repeating do

  # Usage

  # WARNING: The initial import will delete Documents, Keyfindings & Keywords
  # For initial import, call from the command line: heroku run rake "repeating:import[pcyi_initial_import,empty_database]"

  # For ongoing import, set up a scheduled task in Heroku with the command: rake "repeating:import[pcyi_initial_import]"

  desc "Import from Google Drive"
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
      if Rails.env.development? || ws[row, 1].empty?

        doc = Document.new
        doc.report_name = ws[row, 2]
        doc.link = ws[row, 3]
        doc.author = ws[row, 4]
        doc.sponsoring_orgnization = ws[row, 5]
        doc.publication_date = ws[row, 6]
        # Row 7 - Keyfindings. Processed below.
        doc.key_recommendations = ws[row, 8]
        # Row 9 - Keywords. Processed below.
        doc.key_ages = ws[row, 10]
        doc.notes_on_mythodology = ws[row, 11]
        doc.target_population = ws[row, 12]
        doc.data_availablity = ws[row, 13]

        #------------------------------------------------------------------------------
        # Set the tags for age applicability
        if ws[row, 14].eql?("1")
          doc.tag_list.add(ENV['AGE_RANGE_1'])
        end

        if ws[row, 15].eql?("1")
          doc.tag_list.add(ENV['AGE_RANGE_2'])
        end

        if ws[row, 16].eql?("1")
          doc.tag_list.add(ENV['AGE_RANGE_3'])
        end

        #------------------------------------------------------------------------------
        # Set the tags for report type
        if ws[row, 17].eql?('1')
          doc.tag_list.add(ENV['REPORT_TYPE_1'])
        end

        if ws[row, 18].eql?('1')
          doc.tag_list.add(ENV['REPORT_TYPE_2'])
        end

        if ws[row, 19].eql?('1')
          doc.tag_list.add(ENV['REPORT_TYPE_3'])
        end

        if ws[row, 20].eql?('1')
          doc.tag_list.add(ENV['REPORT_TYPE_4'])
        end

        if ws[row, 21].eql?('1')
          doc.tag_list.add(ENV['REPORT_TYPE_5'])
        end

        #------------------------------------------------------------------------------
        begin
          doc.save!
        rescue Exception => e
          puts "Problem with row #{row}"
          puts e.message
        end

        #------------------------------------------------------------------------------
        # Import Keyfindings
        kf_text = ws[row, 7].lstrip.rstrip

        unless kf_text.empty?

          begin
          rescue Exception => e
            puts "Problem with row #{row}. Keyfinding text text: #{kf_text}"
            puts e.message
          end

          kf = Keyfinding.find_or_create_by_keyfinding_text(kf_text)
          doc.keyfindings << kf
        end

        #------------------------------------------------------------------------------
        # Import Keywords
        kw_text_field = ws[row, 9].lstrip.rstrip

        unless kw_text_field.empty?

          keywords = kw_text_field.split(",")

          keywords.each do |keyword_text|
            unless keyword_text.empty?

              begin
                kw = Keyword.find_or_create_by_keyword_text(keyword_text.downcase)
              rescue Exception => e
                puts "Problem with row #{row}. Keyword text: #{keyword_text}"
                puts e.message
              end

              doc.keywords << kw
            end
          end
        end

        # Finished importing the record
        #------------------------------------------------------------------------------

        # Log the Datetime of row import
        ws[row, 1] = "#{DateTime.now.to_s} (Document ID: #{doc.id})"
        puts "#{doc.report_name} (imported)"

      end

      # Quit after importing a number of records when debugging
      # break if (Rails.env.development? && row.eql?(6))
    end
    ws.save

    # Reindex search
    # This line fails when the script is run on production, not sure why. (JM, 2014-08-24)
    # In the meantime, for production:
    # 1) Go to the Elasticsearch dashboard (linked from Heroku addons)
    # 2) Delete any existing indixes
    # 3) Open the Heroku console and run 'Document.reindex'
    Document.reindex unless Rails.env.production?
  end

end