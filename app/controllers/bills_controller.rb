class BillsController < ApplicationController
  # GET /
  def overview
    @bills = current_user.bills.includes(:people_from, :people_to, :debts)
    @friends = current_user.friends

    # Create two arrays of debts
    debts = @friends.map { |f| [f, current_user.owes(f)] }.sort_by { |f, a| -a.abs }
    @you_owe, @owes_you = debts.partition { |f, a| a > 0 }
    @owes_you.map! { |f, a| [f, a.abs] }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bills }
    end
  end

  # GET /bills
  def index
    @bills = current_user.bills.includes(:people_from, :people_to, :debts)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bills }
    end
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
    debt = Debt.new(:amount => @bill.amount)

    if @you_payed
      debt.person_from = current_user
      debt.person_to = @friend
    else
      debt.person_from = @friend
      debt.person_to = current_user
    end

    @bill.debts = [debt]
    @bill.creator = current_user

    respond_to do |format|
      if debt.valid? and @bill.valid?
        debt.save!
        @bill.save!

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
    @bill = current_user.bills.find(params[:id])
    @bill.attributes = params[:bill]
    @friend_name = params[:friend_name]
    @you_payed = params[:you_payed] != "false"
    @friend = current_user.friends.find_or_create_by_name(@friend_name)

    # FIXME update the debt instead of insert/delete
    debt = Debt.new(:amount => @bill.amount)
    if @you_payed
      debt.person_from = current_user
      debt.person_to = @friend
    else
      debt.person_from = @friend
      debt.person_to = current_user
    end

    @bill.debts = [debt]
    @bill.creator = current_user

    respond_to do |format|
      if @bill.valid?
        @bill.save!

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
    @bill = current_user.bills.find(params[:id])
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to(bills_url) }
      format.xml  { head :ok }
    end
  end
end
