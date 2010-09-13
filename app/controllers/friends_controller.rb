class FriendsController < ApplicationController
  # GET /autocomplete.json?term=Foo
  def autocomplete
    friends = {}
    if params[:term] and !params[:term].empty?
      friends = current_user.friends.where(["LOWER(name) LIKE ?", "#{params[:term].downcase}%"]).limit(5).order('name')
    end
    respond_to do |format|
      format.json { render :json => friends.collect { |f| {"id" => f.id, "label" => f.name, "value" => f.name } } }
    end
  end

  # GET /friends
  def index
    @friends = current_user.friends

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @friends }
    end
  end

  # GET /friends/1
  def show
    @friend = current_user_friend
    @owes_you = @friend.owes(current_user)
    @debts = @friend.debts.includes(:bill).order('bills.date DESC, bills.id DESC')

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @friend }
    end
  end

  # GET /friends/new
  def new
    @friend = current_user.friends.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @friend }
    end
  end

  # GET /friends/1
  def edit
    @friend = current_user_friend
  end

  # POST /friends
  def create
    @friend = current_user.friends.build(:name => params[:friend][:name])

    respond_to do |format|
      if @friend.save
        format.html { redirect_to(friends_url, :notice => 'Friend was successfully created.') }
        format.xml  { render :xml => @friend, :status => :created, :location => @friend }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @friend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /friends/1
  def update
    @friend = current_user_friend

    respond_to do |format|
      if @friend.update_attributes(params[:friend])
        format.html { redirect_to(friends_path, :notice => 'Friend was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @friend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  def destroy
    @friend = current_user_friend
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to(friends_url) }
      format.xml  { head :ok }
    end
  end

end
