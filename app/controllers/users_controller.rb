class UsersController < ApplicationController

  enable :sessions
  set :session_secret, "pollywog"

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


  post '/signup' do
    @user = User.create(params)
    if @user.valid?
      session[:user_id] = @user.id
      current_user
      redirect "/tweets"
    else
     redirect "/signup"
    end
  end

  get '/logout' do
    if !logged_in?
      redirect '/'
    else
      session.clear
      redirect '/login'
    end
  end


  get '/users/:slug' do
    if !logged_in?
      redirect '/login'
    else
    @current_user = User.find(session[:user_id])
    erb :'users/show'
    end
  end

end
