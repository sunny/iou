class FriendsController < ApplicationController
  respond_to :html, :xml

  # GET /autocomplete.json?term=Foo
  def autocomplete
    @friends = []
    if params[:term] and !params[:term].empty?
      @friends = current_user.friends.where(["LOWER(name) LIKE ?", "#{params[:term].downcase}%"]).limit(5).order('name')
    end
    respond_with(@friends) do |format|
      format.json { render :json => @friends.collect { |f| {"id" => f.id, "label" => f.name, "value" => f.name } } }
    end
  end

  # GET /friends
  def index
    @friends = current_user.friends

    respond_with @friends
  end

  # GET /friends/1
  def show
    @friend = current_user_friend
    @owes_you = @friend.owes(current_user)
    @debts = @friend.debts.includes(:bill).order('bills.date DESC, bills.id DESC')

    respond_with @friends
  end

  # GET /friends/new
  def new
    @friend = current_user.friends.build

    respond_with @friends
  end

  # GET /friends/1
  def edit
    @friend = current_user_friend
  end

  # POST /friends
  def create
    @friend = current_user.friends.create(:name => params[:friend][:name])
    respond_with(@friend, :location => friends_url)
  end

  # PUT /friends/1
  def update
    @friend = current_user_friend
    @friend.update_attributes(params[:friend])
    respond_with(@friend, :location => friends_path)
  end

  # DELETE /friends/1
  def destroy
    @friend = current_user_friend
    @friend.destroy

    respond_with @friend
  end

end
