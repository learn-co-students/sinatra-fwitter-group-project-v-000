class UsersController < ApplicationController
  get '/signup' do
    if !session[:id]
      erb :"users/create_user"
    else
      redirect to '/tweets' 
    end
  end

  post '/signup' do
    #Create a new user and save to DB
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    
    if @user.username == "" || @user.email == ""
      redirect to '/signup'
    elsif @user.save
      session[:id] = @user.id

      redirect to '/tweets'
    else
      redirect to "/signup"
    end    
  end

  get '/login' do
    if !session[:id]
      erb :"users/login"
    else
      redirect to '/tweets' 
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if !session
      redirect to '/'
    else
    session.clear
      redirect to '/login'
    end
  end
end
