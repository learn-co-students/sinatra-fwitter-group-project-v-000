class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

#Loads the signup page
  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/tweets'
    end
  end

#Creates new user and logs them in on valid submission
#Does not let a logged in user view the signup page
  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end
  
  #Loads the login page
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end
  
  post '/login' do
    user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
