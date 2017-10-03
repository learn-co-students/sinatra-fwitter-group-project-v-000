require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
  end

  get '/' do
    if logged_in?
      erb :'users/index'
    else
      erb :index
    end
  end

  get '/users/:slug' do
    @user = User.all.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'users/index'
    else
      redirect '/login'
    end
  end

  #create tweets:  get & post
  get '/tweets/new' do
    if logged_in?
      erb :'users/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    #can't submit an empty tweet
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = current_user.tweets.create(:content => params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  #show tweets: get
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = current_user
      erb :'users/show'
    else
      redirect '/login'
    end
  end

  #edit tweets: get & post
  get '/tweets/:id/edit' do
    #can only edit post if it belongs to current user
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        erb :'/users/edit'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end



  #sign up: get & post
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/registrations/signup'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  #login: get & post
  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/sessions/login'
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

  #logout: get
  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end

  #delete tweets: post
  delete '/tweets/:id/delete' do
    #can only delete a tweet if it belongs to current user
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.destroy
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end

  end

  helpers do
    def current_user
      @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end
  end


end
