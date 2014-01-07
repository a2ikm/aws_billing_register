task :import => :environment do
  Account.all.each do |account|
    account.cost_allocation_csv_objects.each do |object|
      report = account.find_or_initialize_report_for_s3object(object)
      
      if !report.persisted? || report.last_modified < object.last_modified
        report.last_modified = object.last_modified
        report.save!

        CsvRegister.execute!(report, object.read)
      end
    end
  end
end
