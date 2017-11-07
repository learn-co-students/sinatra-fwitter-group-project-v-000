class UserController < ApplicationController

  get '/users/:id' do
    # binding.pry
    if logged_in?
      @user = current_user
      erb :'users/show'
    else
      redirect to '/failure'
    end
  end

  

end
