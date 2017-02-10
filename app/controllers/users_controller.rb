class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect_to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    user = User.create(params)
    if user.save
      session[:id] = user.id
      redirect to '/tweets'
    else
      flash[:notice] = "Please fill out all fields."
      redirect to '/signup'
    end
  end

end
