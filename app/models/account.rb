class Account < ActiveRecord::Base
  has_many :cost_allocations
end
