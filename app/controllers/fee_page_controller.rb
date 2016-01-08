class FeePageController < ApplicationController
  def index
    @fee = Fee.find(params[:id])
    @ft = FeeTransaction.where(fee_id: @fee.id)
  end
end
