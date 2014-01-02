class CsvRegister
  def self.execute!(account, csv_string)
    new(account).execute!(csv_string)
  end

  def initialize(account)
    @account = account
  end

  def execute!(csv_string)
    csv_string = cleanup_csv_string(csv_string)
    csv = CSV.parse(csv_string, headers: true)

    register_user_tags(csv.headers)
    register_records(csv)
  end

  private

    def cleanup_csv_string(csv_string)
      lines = csv_string.split(/\n/)

      x_lines = []
      flag = false
      lines.each do |line|
        flag = flag || line =~ /^InvoiceID/
        x_lines << line if flag
      end

      x_lines.join("\n")
    end

    def register_user_tags(csv_headers)
      csv_headers.each do |header|
        next unless match = header.match(/^user:(.+)/) and tag_name = match[1]
        # create Tag record
      end
    end

    def register_records(csv)
      csv.each do |row|
        break if row["InvoiceID"].blank?
        next unless row["RecordType"] == "PayerLineItem"
        register_record(row)
      end
    end

    def register_record(row)
      CostAllocation.where(record_id: row["RecordID"]).first_or_create! do |cost_allocation|
        cost_allocation.billing_period_start_date = parse_time(row["BillingPeriodStartDate"])
        cost_allocation.billing_period_end_date   = parse_time(row["BillingPeriodEndDate"])
        cost_allocation.invoice_date              = parse_time(row["InvoiceDate"])
        cost_allocation.product                   = product(row["ProductCode"], row["ProductName"])
        cost_allocation.usage_type                = usage_type(row["UsageType"])
        cost_allocation.availability_zone         = availability_zone(row["AvailabilityZone"])
        cost_allocation.usage_quantity            = row["UsageQuantity"]
        cost_allocation.total_cost                = row["TotalCost"].to_f
      end
    end

    def parse_time(time_string)
      ActiveSupport::TimeZone["UTC"].parse(time_string)
    end

    def product(code, name)
      Product.where(code: code).first_or_create! do |product|
        product.name = name
      end
    end

    def usage_type(name)
      UsageType.where(name: name).first_or_create!
    end

    def availability_zone(name)
      AvailabilityZone.where(name: name).first_or_create!
    end
end
