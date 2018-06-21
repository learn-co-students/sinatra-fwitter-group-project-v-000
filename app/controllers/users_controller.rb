class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if @user.save
      redirect :'/tweets'
    else
      redirect :'/signup'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    erb :"/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    erb :'/tweets/show_tweet'
  end

end
