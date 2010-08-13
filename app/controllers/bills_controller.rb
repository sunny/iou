class BillsController < ApplicationController
  # GET /bills
  def index
    @bills = Bill.includes(:people_from, :people_to, :debts)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bills }
    end
  end

  # GET /bills/1
  def show
    @bill = Bill.find(params[:id])
    @friend = @bill.people.find { |p| current_user.friends.include?(p) }
    @you_payed = @bill.people_from == [current_user]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/new
  def new
    @bill = Bill.new
    @friend_name = ""
    @you_payed = true

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/1/edit
  def edit
    @bill = Bill.find(params[:id])
    @friend_name = @bill.people.find { |p| current_user.friends.include?(p) }.try(:name)
    @you_payed = @bill.people_from == [current_user]
  end

  # POST /bills
  def create
    @bill = Bill.new(params[:bill])
    @friend_name = params[:friend_name]
    @you_payed = params[:you_payed] != "false"
    friend = current_user.friends.find_or_initialize_by_name(@friend_name)
    debt = Debt.new(:amount => @bill.amount, :bill => @bill)

    if @you_payed
      debt.person_from = current_user
      debt.person_to = friend
    else
      debt.person_from = friend
      debt.person_to = current_user
    end

    @bill.debts = [debt]

    respond_to do |format|
      if @bill.save
        format.html { redirect_to(@bill, :notice => 'Bill was successfully created.') }
        format.xml  { render :xml => @bill, :status => :created, :location => @bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bills/1
  def update
    @bill = Bill.find(params[:id])
    @bill.attributes = params[:bill]
    @friend_name = params[:friend_name]
    @you_payed = params[:you_payed] != "false"
    friend = current_user.friends.find_or_initialize_by_name(@friend_name)

    debt = @bill.debt
    debt.amount = @bill.amount
    if @you_payed
      debt.person_from = current_user
      debt.person_to = friend
    else
      debt.person_from = friend
      debt.person_to = current_user
    end

    respond_to do |format|
      if debt.save and @bill.save
        format.html { redirect_to(@bill, :notice => 'Bill was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to(bills_url) }
      format.xml  { head :ok }
    end
  end
end
