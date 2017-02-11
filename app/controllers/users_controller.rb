class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/signup' do
    user = User.create(params)
    if user.save
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      flash[:notice] = "Please fill out all fields."
      redirect to '/signup'
    end
  end

end
