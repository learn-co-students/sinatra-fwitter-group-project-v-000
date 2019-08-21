require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "tweetkcret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
	  else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
	  end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect "/tweets"
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
    session.clear
    redirect "/login"
  end

  get '/users/:slug' do
    if current_user.username.slugify == params[:slug]
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    else
      redirect "/tweets"
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
    if logged_in?
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect "/tweets/new"
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      @tweet.save
      redirect "/tweets"
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

  get '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])

    if current_user.id == tweet.user_id
      tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in? && current_user.tweets.ids.include?(params[:id].to_i)
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    elsif logged_in? && !current_user.tweets.ids.include?(params[:id].to_i)
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/users/#{current_user.username.slugify}"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= User.find(session[:user_id])
    end
  end
end
