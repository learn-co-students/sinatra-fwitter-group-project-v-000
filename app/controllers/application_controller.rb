require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if !logged_in?
      erb :index
    else
      erb :'tweets/index'
    end
  end

  get '/signup' do
    if session[:id] != nil
      redirect "/tweets"
    else
      erb :signup
    end
  end

  post '/signup' do
    @user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password]
    )
    if @user.save
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if !logged_in?
      erb :login
    else
      redirect "/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/tweets"
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

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/new' do
    if params[:content].length.between?(1,141)
      @tweet = Tweet.create(
      content: params[:content],
      user_id: current_user.id
      )
      redirect "/tweets/#{@tweet.id}"
    else
      redirect 'tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = current_tweet
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in? && current_user.id == session[:id]
      @tweet = current_tweet
      erb :'tweets/edit'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = current_tweet
    @tweet.update(content: params[:content])
    erb :'tweets/show'
  end

  delete '/tweets/:id/delete' do
    if logged_in? && current_user.id == current_tweet.user_id
      @tweet = current_tweet
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end

  get '/users/:slug' do
    @user = User.all.find_by_slug(params[:slug])
    erb :'users/show'
  end


	def logged_in?
		!!session[:id]
	end

	def current_user
		User.find(session[:id])
	end

  def current_tweet
    Tweet.find_by_id(params[:id])
  end

end
