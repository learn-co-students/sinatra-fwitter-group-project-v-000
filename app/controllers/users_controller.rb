class UsersController < ApplicationController
    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    end

    #  loads the signup page
    get '/signup' do
      if !logged_in?
        erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
      else
        redirect to '/tweets'
      end
    end
  
    # creates a new user and logs them in on valid submission and does not let 
    # a logged in user view the signup page
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
  
    get '/login' do 
      if !logged_in?
        erb :'users/login'
      else
        redirect '/tweets'
      end
    end
  
    post '/login' do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
      else
        redirect to '/signup'
      end
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