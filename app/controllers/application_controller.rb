require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'/index'
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'users/show'
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    if @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user_id: current_user.id)
    if @tweet.save
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.id == @tweet.user_id
      @tweet.destroy
      redirect to '/tweets'
    elsif logged_in?
      redirect to "/tweets"
    else
      redirect to '/login'
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
