require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end


  # Helper Methods
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

# Index
  get '/' do
    @session = session
    erb :index
  end

# User controls
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/signup' do
    if params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect '/signup'
    else
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect ''
    end
  end

  post '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect ''
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  # Tweet controls

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets/new' do
    if logged_in?
      if params[:content] != ""
        @tweet = Tweet.new(content: params["content"], user_id: session[:user_id])
        @tweet.user = current_user
        @tweet.save
        erb :'/tweets/show_tweet'
      else
        redirect "/tweets/new"
      end
    else
      redirect "/login"
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      @user = current_user
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      if !current_user
        redirect "/tweets/#{params[:id]}"
      else
        @edit_tweet = Tweet.find(params[:id])
        erb :'/tweets/edit_tweet'
      end
    else
      redirect "/login"
    end
  end


  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if current_user
      if params["content"] != ""
        tweet.content = params["content"]
        tweet.save
        redirect "/tweets/#{params[:id]}/edit"
      else
        redirect "/tweets/#{params[:id]}/edit"
      end
    else
      erb :"/tweets/:id/edit"
    end
  end

  post '/tweets/:id/delete' do
    @user = current_user
    @tweet = Tweet.find(params[:id])
    if logged_in?
      if @tweet.user_id == session[:id]
        @tweet.delete
        redirect '/tweets'
      else
        redirect "/tweets/#{params[:id]}"
      end
    else
      redirect "/tweets/#{params[:id]}"
    end
  end



end
