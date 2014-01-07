class Report < ActiveRecord::Base
  belongs_to :account
  has_many :cost_allocations
end
