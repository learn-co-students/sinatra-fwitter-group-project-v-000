require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret_sause"
  end

  # Home page
  get '/' do
    session.clear
    erb :index
  end

  #Tweets

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  # Create new tweet
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  # New tweet posts and redirects to the show tweet page
  post '/tweets' do
    puts params
    @user = current_user
    @tweet = Tweet.create(params[:tweet])
    if @tweet.save
      @user.tweets << @tweet
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end


  # Shows single tweet
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(params[:tweet])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  # User

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  # Create the new user with un, email and pw
  # assign the auto generated user id to the session id
  post '/signup' do
    puts params
    @user = User.create(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to "/login"
    else
      redirect to '/'
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

