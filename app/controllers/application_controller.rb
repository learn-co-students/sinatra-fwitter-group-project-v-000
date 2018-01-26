require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "waltsentme"
  end

  get '/' do
    if logged_in?
      user = User.find(current_user.id)
      redirect to "/users/#{user.slug}"
    else
      erb :index
    end
  end

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:email] == "" || params[:username] == "" || params[:password] == ""
      redirect to "/signup"
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find(current_user.id)
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = User.find(current_user.id)
      erb :'tweets/create_tweets'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      user = User.find(current_user.id)
      tweet = Tweet.create(content: params[:content])
      user.tweets << tweet
      redirect to "tweets/#{tweet.id}"
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = User.find(current_user.id)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if tweet.user.id != current_user.id
      redirect to "/tweets"
    elsif params[:content] != ""
      tweet.content = params[:content]
      tweet.save
      redirect to "/tweets/#{tweet.id}"
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if tweet.user.id == current_user.id
      tweet.delete
      tweet.save
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
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
