task :import => :environment do
  Account.all.each do |account|
    time = Time.now
    csv_string = account.cost_allocation_csv_string_for(time)
    CsvRegister.execute!(account, csv_string)
  end
end
