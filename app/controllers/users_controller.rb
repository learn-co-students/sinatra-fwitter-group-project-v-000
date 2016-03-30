class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      @message = "Oops, something didn't work.  Try again."
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      logout
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    @tweets = Tweets.find_by_user_id(@user.id)

    erb :'users/show'
  end
end