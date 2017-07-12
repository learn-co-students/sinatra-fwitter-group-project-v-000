class UsersController < ApplicationController

  get '/users/:slug' do #slug to add----
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/new' #to erb: create new user form 3 input fields
    else
      redirect to "/tweets"
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else

      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to "/login"
    else
      redirect to '/'
    end
  end

end
