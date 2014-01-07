class Report < ActiveRecord::Base
  belongs_to :account
  has_many :cost_allocations

  def date
    persisted? ? Date.new(year, month) : nil
  end
end
