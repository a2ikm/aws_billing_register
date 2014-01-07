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

  def cost_allocation_csv_string_for(time)
    object_name = "%s-aws-cost-allocation-%d-%02d.csv" % [account_id, time.year, time.month]
    object = bucket.objects[object_name]

    if object = bucket.objects[object_name]
      object.read
    else
      raise "No object named `#{object_name}` in bucket `#{bucket_name}` for account `#{name}`"
    end
  end
end
