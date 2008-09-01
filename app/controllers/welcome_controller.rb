class WelcomeController < ApplicationController
  def index
    if current_user
      return render(:action => 'home')
    end
  end
end
