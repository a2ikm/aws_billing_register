class CostAllocation < ActiveRecord::Base
  belongs_to :product
  belongs_to :usage_type
  belongs_to :availability_zone
end
