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
    if session[:user_id]
      redirect to 'tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params["username"].empty? || params["password"].empty? || params["email"].empty?
      redirect to '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect to '/tweets'
    end
  end

  get '/login' do 
    if session[:user_id]
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params["username"])
    if user && user.authenticate(params["password"])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      "Wrong Password"
      redirect to '/login'
    end
  end

  get '/tweets' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @view = @user
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_id(session["user_id"])
    @view = User.find_by_slug(params[:slug])
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    if Helper.logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      #raise alert saying you're not logged in
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params["content"].empty?
      #raise alert here, look back at last lesson to raise alert.
      redirect to '/tweets/new'
    else
      @user = Helper.current_user(session)
      @user.tweets << Tweet.create(params)
      @user.save
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do
    if Helper.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helper.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    
    if params["content"].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params["content"]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.id == session["user_id"]
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end







end