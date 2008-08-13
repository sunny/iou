class BillsController < ApplicationController
  def index
    @bills = Bill.all
  end

  def show
    @bill = Bill.find params[:id]
  end

  def new
    @bill = Bill.new
  end

  def create
    @bill = Bill.create(params[:bill])
    if @bill.errors.empty?
      redirect_to @bill
    else
      render :action => 'new'
    end
  end
end
