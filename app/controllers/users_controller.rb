class UsersController < ApplicationController

  get '/signup' do
    if !session[:user_id]
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  get '/login' do
    if logged_in?
    redirect to '/tweets'
    else
    erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        erb :'/users/login'
      end
  end

  post '/signup' do
    if params[:password] == ""
      redirect '/signup'
    end
    user = User.new(params)
    if user.username != "" && user.email != ""
      user.save
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do

  end


end
