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
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:id] = @user.id
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
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
    @tweet = Tweet.create(content: params[:content], user_id: session[:id])
    @tweet.save
    redirect "/tweets"
  end

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:id])
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user = current_user
    erb :'/tweets/show_tweet'
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
         erb :'tweets/edit_tweet'
       else
         redirect "/tweets"
       end
    else
      redirect "/login"
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    redirect "/tweets"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user == @tweet.user
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end


  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end
  end

end
