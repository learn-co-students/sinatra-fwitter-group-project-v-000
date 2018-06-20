class UsersController < ApplicationController

  #shows sign up page
  get '/signup' do
    if logged_in? #if already logged in, redirect to '/tweets'
      redirect '/tweets'
    else
      erb :'users/signup' #if not logged in, show signup form
    end
  end

  #take info from params and make a new User instance, save to database
  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup' #if any fields are empty, show signup page again
    else
      @user = User.new(params) #creates new user instance with params values
      @user.save #save user to database
      session[:user_id] = @user.id #logs user in
      redirect '/tweets' #redirect to tweets page
    end
  end

#show login page
  get '/login' do
    if !logged_in?
        erb :'users/login' #if not logged in, show login page
    else
        redirect '/tweets' #if logged in already, redirect to tweets page
    end
  end

  #take login params values and redirect user to tweets index
  post '/login' do
    user = User.find_by(:username => params[:username])
    #@user will be true if its username is found in database (line 35)
    if user && user.authenticate(params[:password]) #&& !logged_in?
      session[:user_id] = user.id
      #binding.pry
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

#logout
  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :'/users/show'
  end

end
