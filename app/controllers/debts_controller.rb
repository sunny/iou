class DebtsController < ApplicationController
  # GET /debts
  def index
    @debts = Debt.all :include => [:people_from, :people_to, :bill]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @debts }
    end
  end

  # GET /debts/1
  def show
    @debt = Debt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @debt }
    end
  end

  # GET /debts/new
  def new
    @debt = Debt.new(params[:debt])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @debt }
    end
  end

  # GET /debts/1/edit
  def edit
    @debt = Debt.find(params[:id])
  end

  # POST /debts
  def create
    @debt = Debt.new(params[:debt])

    respond_to do |format|
      if @debt.save
        format.html { redirect_to(@debt, :notice => 'Debt was successfully created.') }
        format.xml  { render :xml => @debt, :status => :created, :location => @debt }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @debt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /debts/1
  def update
    @debt = Debt.find(params[:id])

    respond_to do |format|
      if @debt.update_attributes(params[:debt])
        format.html { redirect_to(@debt, :notice => 'Debt was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @debt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /debts/1
  def destroy
    @debt = Debt.find(params[:id])
    @debt.destroy

    respond_to do |format|
      format.html { redirect_to(debts_url) }
      format.xml  { head :ok }
    end
  end
end
