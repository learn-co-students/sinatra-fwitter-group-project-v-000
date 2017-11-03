class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to "/tweets"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect "/signup"
    else
      @user = User.new(:username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end
  
  get '/login' do 
    if !logged_in?
      erb :'users/login'
    else
      redirect to "/tweets"
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else 
      redirect "/login"
    end
  end

  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end




end



