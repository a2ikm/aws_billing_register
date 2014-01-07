class ReportsController < ApplicationController
  helper_method :account

  def index
    @reports = account.reports.includes(cost_allocations: [:product, :usage_type, :availability_zone])
    @report = @reports.last
  end

  def show
    @reports = account.reports.includes(cost_allocations: [:product, :usage_type, :availability_zone])
    @report = @reports.find(params[:id])
  end

  private

    def account
      @account ||= Account.find(params[:account_id])
    end
end
