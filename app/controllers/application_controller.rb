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
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_users'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'/tweets/create_tweets'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      erb :"/tweets/show_tweet"
    else
      redirect '/login'
    end
  end


  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.create(content: params[:content])
      tweet.user_id=session[:user_id]
      tweet.save
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        erb :"/tweets/edit_tweet"
      else
        redirect "/tweets"
      end
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
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
