require './config/environment'

class ApplicationController < Sinatra::Base

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
    if session.has_key?(:id)
      @user = User.find(session[:id])
      redirect "/tweets"
    else
      erb :signup
    end
  end

  get '/tweets' do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  get "/login" do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      redirect "/tweets"
    else
      erb :login
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  get "/tweets/new" do
    if session.has_key?(:id)
      erb :"/tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id" do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  post "/signup" do
    if params.values.any?(&:empty?)
      redirect "/signup"
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect "/tweets"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      @user = user
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  post "/tweets/new" do
    if params[:content].empty?
      redirect "/tweets/new"
    else
      @tweet = Tweet.create(params)
      @tweet.update(user_id: session[:id])
      redirect "/tweets/#{@tweet.id}"
    end
  end

end
