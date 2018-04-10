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
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end


  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
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

  get "/users/:slug" do
    @user = User.find_by(username: params[:slug])
    erb :'/users/show'
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = current_user
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = current_user
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.update(params[:tweet])
      @tweet.save
    else
      redirect '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

  post '/tweets/new' do
    if params[:tweet][:content].empty? || params[:tweet][:content].split.size < 1
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(params[:tweet])
      @tweet.user = current_user
      @tweet.save
      redirect '/tweets'
    end
  end



  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  helpers do
    def logged_in? #returns true if logged in
      !!session[:user_id]
    end

    def current_user
      #tests to see if there is a session param called :user_id
      #if there is one, that means that a user was created and saved to the database
      #if so, this uses the find method on User to find that user instance
      if session[:user_id]
        @current_user = User.find(session[:user_id])
      end
    end
  end

end
