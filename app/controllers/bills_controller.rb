class BillsController < ApplicationController
  respond_to :html, :xml

  # GET /
  def overview
    @bills = current_user.bills.includes(:people_from, :people_to, :debts)
    @friends = current_user.friends

    # Create two arrays of debts
    debts = @friends.map { |f| [f, current_user.owes(f)] } \
                    .reject { |f, a| a == 0 } \
                    .sort_by { |f, a| -a.abs }
    @you_owe, @owes_you = debts.partition { |f, a| a > 0 }
    @owes_you.map! { |f, a| [f, a.abs] }

    @total_owes_you = @owes_you.sum { |f, a| a }
    @total_you_owe = @you_owe.sum { |f, a| a }
  end

  # GET /bills
  def index
    @bills = current_user.bills.includes(:people_from, :people_to, :debts)
    respond_with @bills
  end

  # GET /bills/1
  def show
    @bill = current_user.bills.find(params[:id])
    person_from = @bill.people_from.first
    person_to = @bill.people_to.first

    if current_user == person_from
      @you_payed = true
      @friend = person_to
    else
      @you_payed = false
      @friend = person_from
    end

    respond_with @bill
  end

  # GET /bills/new
  def new
    @bill = Bill.new
    @friend_name = ""
    @you_payed = true

    respond_with @bill
  end

  # GET /bills/1/edit
  def edit
    @bill = current_user.bills.find(params[:id])
    @friend_name = @bill.people.find { |p| current_user.friends.include?(p) }.try(:name)
    @you_payed = @bill.people_from == [current_user]
  end

  # POST /bills
  def create
    @bill = Bill.new(params[:bill])
    @friend_name = params[:friend_name]
    @you_payed = params[:you_payed] != "false"
    @friend = current_user.friends.find_or_create_by_name(@friend_name)
    debt = Debt.new(:amount => @bill.amount, :bill => @bill)

    if @you_payed
      debt.person_from = current_user
      debt.person_to = @friend
    else
      debt.person_from = @friend
      debt.person_to = current_user
    end

    @bill.debts = [debt]
    @bill.creator = current_user

    @bill.save
    respond_with @bill
  end

  # PUT /bills/1
  def update
    @bill = current_user.bills.find(params[:id])
    @bill.attributes = params[:bill]
    @friend_name = params[:friend_name]
    @you_payed = params[:you_payed] != "false"
    @friend = current_user.friends.find_or_create_by_name(@friend_name)

    # FIXME update the debt instead of insert/delete
    debt = Debt.new(:amount => @bill.amount, :bill => @bill)
    if @you_payed
      debt.person_from = current_user
      debt.person_to = @friend
    else
      debt.person_from = @friend
      debt.person_to = current_user
    end

    @bill.debts = [debt]
    @bill.creator = current_user

    @bill.save
    respond_with @bill
  end

  # DELETE /bills/1
  def destroy
    @bill = current_user.bills.find(params[:id])
    @bill.destroy

    respond_with @bill
  end
end
