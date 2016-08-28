class UsersController < ApplicationController

  get '/users' do 
    @users = User.all
    erb :'/users/index'
  end

  get '/users/signup' do
    erb :'/users/signup'
  end

  post '/users/signup' do
     if params[:username] == "" || params[:password] == ""
      redirect "error"
    else
      redirect '/users/login'
    end
  end

  # get '/users/:slug' do 
  #   @artist = User.find_by_slug(params[:slug])
  #   erb :'/users/show_tweets' 
  # end
   
  get '/users/login' do
    erb :'users/login'
  end


  post '/users/login' do #-- login page
    @user = User.find_by(:username => params[:username])
    if @user != nil && @user.password == params[:username] 
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
    erb :error
  end

  post '/users/signup' do
     if params[:username] == "" || params[:password] == ""
      redirect "error"
    else
      redirect '/users/index'
    end
  end

  get '/users/logout' do#-- logout takes back to home
    session.clear
    redirect to '/'
  end

  get '/users/home' do
    @user = User.find(session[:id])
  erb :'/users/home'
  end



end