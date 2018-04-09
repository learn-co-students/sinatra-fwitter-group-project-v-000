require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "fwitter_password"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if !!user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

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

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    user = current_user
    user.tweets.build(params)
    if user.tweets.last.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user == @tweet.user
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if current_user == tweet.user
      tweet.delete
      redirect "/tweets"
    else
      redirect "/tweets/#{tweet.id}"
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
