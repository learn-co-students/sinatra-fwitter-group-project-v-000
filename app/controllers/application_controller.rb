require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  erb :'/index'
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to('/tweets')
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect to("/signup")
    end

    user= User.create(params)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to('/tweets')
    else
        redirect "/signup"
    end
    #erb :'/tweets/tweets'
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
    erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to('/tweets')
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to('/tweets')
      else
        redirect '/login'
      end
  end

  get '/logout' do
    #clear session hash
      session.clear
      redirect to '/login'
  end

  post '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/tweets/new' do
    if logged_in?
    erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to('/tweets/new')
    else
      @tweet = Tweet.create(params)
      @tweet.user_id = current_user[:id]
      @tweet.save
      redirect to("/tweets/#{@tweet.id}")
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.all.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to('/login')
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
      erb :'/tweets/edit_tweet'
      else
        redirect to("/tweets/#{@tweet.id}")
      end
    else
      redirect to('/login')
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect to("/tweets/#{@tweet.id}/edit")
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect to("/tweets/#{@tweet.id}")
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
    @tweet.destroy
    redirect to('/tweets')
    else
      redirect to("/tweets/#{@tweet.id}")
    end
  end

  get '/users/:slug' do
    #binding.pry
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end


end
