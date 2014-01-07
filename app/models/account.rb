class Account < ActiveRecord::Base
  has_many :reports

  def s3
    @s3 ||= AWS::S3.new(
      access_key_id:      access_key_id,
      secret_access_key:  secret_access_key,
      region:             region
    )
  end

  def bucket
    s3.buckets[bucket_name] or
      raise "No bucket named `#{bucket_name}` for account `#{name}`"
  end

  def cost_allocation_csv_objects
    prefix = "#{account_id}-aws-cost-allocation-"
    bucket.objects.with_prefix(prefix)
  end

  def find_or_initialize_report_for_s3object(s3object)
    if match = /-(\d{4})-(\d{2})\.csv$/.match(s3object.key)
      year  = match[1]
      month = match[2]
      reports.where(year: year, month: month).first_or_initialize
    else
      raise "missmatch: #{s3object.key}"
    end
  end
end
