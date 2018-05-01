require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do

    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect "/signup"
    else

      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets"
    end

    erb :'/users/create_user'
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by_username(params[:username])

    if User.all.include?(@user) && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect "/tweets"
    end

    erb :'/users/login'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    end
    redirect "/tweets"
  end

  get '/tweets' do
    @tweets = Tweet.all

    if !logged_in?
      redirect "/login"
    end
    erb :'/tweets/tweets'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :'/users/show'
  end

  get '/tweets/new' do
    if !logged_in?
      redirect "/login"
    end

    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    if params[:content] == ""
      redirect "/tweets/new"
    elsif logged_in?
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])

      redirect "/tweets"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if logged_in?
      erb :'/tweets/show_tweet'
    elsif !logged_in?
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do

    @tweet = Tweet.find_by_id(params[:id])

    if logged_in? && @tweet.user_id ==  current_user.id
  erb :'/tweets/edit_tweet'
    elsif !logged_in?
      redirect "/login"
    end
  end

  patch '/tweets/:id' do


    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      if params[:content] != "" && params[:content] != nil
        @tweet.content = params[:content]
        @tweet.save
      elsif params[:content] == ""
        redirect "/tweets/#{@tweet.id}/edit"
      end
    elsif !logged_in?
      redirect "/login"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if !logged_in?
      redirect "/login"
    elsif logged_in? && @tweet.user_id == current_user.id
      tweet = Tweet.find(params[:id])
      tweet.delete
      redirect "/tweets"
    end
  end


  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
