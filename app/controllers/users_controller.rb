class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
  get '/signup' do
    # "hello i am the sign up page"
    # binding.pry
    if !logged_in?
      erb :"users/signup"
    else
      redirect '/tweets'
    end
    erb :'users/signup'
  end
  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?

      redirect "/signup"
    else

      @user = User.create(:username => params[:username], :email => params[:email],:password => params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
    # "hello I am the user record successfully signed up show user"
    erb :'tweets/index'
  end
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end
  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      # binding.pry
      session[:user_id] = @user.id
      # binding.pry
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end
  get '/logout' do
    # "you are looged out"
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
end
