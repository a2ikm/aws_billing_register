class Report < ActiveRecord::Base
  belongs_to :account
  has_many :cost_allocations

  def date
    persisted? ? Date.new(year, month) : nil
  end

  def sum_total_costs
    cost_allocations.sum(:total_cost)
  end
end
