require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !Helpers.logged_in?(session)
      erb :'users/create_user'
    else
      redirect to "/tweets"
    end
  end

  post '/signup' do
    if !params.any? { |k,v| v.empty? }
      user = User.create(username: params[:username], email: params[:email],
      password: params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      flash[:message] = "Signup failed. Please try again."
      redirect to "/signup"
    end
  end

  get '/login' do
    if !Helpers.logged_in?(session)
      erb :'users/login'
    else
      redirect to "/tweets"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      flash[:message] = "Login failed. Please try again."
      redirect to "/login"
    end
  end

  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
    end
    redirect to "/login"
  end

  get '/tweets' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    @user = Helpers.current_user(session)
    if @user
      erb :'tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      new_tweet = Tweet.create(content: params[:content])
      user = Helpers.current_user(session)
      new_tweet[:user_id] = user.id
      user.tweets << new_tweet
      user.save
      redirect to "/tweets/#{new_tweet.id}"
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  post '/tweets/:id' do
    user = Helpers.current_user(session)
    tweet = Tweet.find(params[:id])
    if !params[:content].empty? && tweet.user_id == user.id
      tweet.update(content: params[:content])
      redirect to "/tweets/#{tweet.id}"
    else
      redirect to "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    user = Helpers.current_user(session)
    if user && tweet.user_id == user.id
      tweet.delete
      redirect to "/tweets"
    else
      redirect to "/tweets/#{tweet.id}"
    end
  end

  get '/users/:slug' do
    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :'users/show'
  end

end
