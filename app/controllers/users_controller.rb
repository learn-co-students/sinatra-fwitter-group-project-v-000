class UsersController < ApplicationController

  get '/users/:slug' do
    #get user and show their user page.
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

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
    #if not logged in, show login page
    if !logged_in?
      erb :'users/login'
      #if logged in, show personal tweets page
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    #find and set user by username
    user = User.find_by(:username => params[:username])
    #if user exists and password is authenticated, set session id to user.id
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      #redirect user to their tweets page
      redirect to '/tweets'
    else
      #if user could not be authenticated, redirect to sign up page
      redirect to '/signup'
    end
  end

  get '/logout' do
    # if user is logged in, clear session
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      #if not logged in, redirect to index home (that has login and signup links)
      redirect to '/'
    end
  end


end
