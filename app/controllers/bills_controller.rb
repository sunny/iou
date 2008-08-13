class BillsController < ApplicationController
  def index
    @bills = Bill.all
  end
  
  def show
    @bill = Bill.find params[:id]
  end
end
