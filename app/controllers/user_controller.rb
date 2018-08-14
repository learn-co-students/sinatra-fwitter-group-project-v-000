class UserController < ApplicationController

  get '/signup' do
     if !logged_in?
       erb :'/users/new'
     else
       redirect "/tweets"
     end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
        user = User.create(username: params[:username], email: params[:email], password: params[:password])
        session[:user_id] = user.id
        user.save
        redirect "/tweets"
      else
        redirect "/signup"
    end
  end

  get '/login' do #loads login page
    if logged_in?
      redirect "/tweets"
    else
    erb :'/users/login'
    end
  end

  post '/login' do #loads login page

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
      #  binding.pry
        redirect "/tweets"
    else
        redirect "/login"
    end
  end

  get '/logout' do
      session.clear
      redirect "/login"
  end

  get '/show' do
    binding.pry
    #  @user = User.find_by(id: session[:user_id])
    #  tweets =Tweet.find by(user_id: @user.id)
      erb :'/show'
    end

end
