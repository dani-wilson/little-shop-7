class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    get_random_photo
  end
end
