class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/login'
    end
  end

  post '/login' do
     user = User.find_by(username: params[:username])
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect '/tweets'
     else
       redirect "/signup"
     end
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/create_user'
    end
  end


end
