require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
     redirect to '/tweets' 
   else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    # if !User.find_by(username: params[:username]) && !User.find_by(email: params[:email])
      user = User.new(params)
    # else
      # user = User.new
    # end
    if user.save
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
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
    user = User.find_by(username: params[:username]) 
    if !!user && user.authenticate(params[:password])
      session[:id] = user.id
    end
    redirect "/tweets"
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect 'login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect 'login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      current_user.tweets << Tweet.new(params)
      redirect '/tweets'
    end
      redirect '/tweets/new'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in? && current_user.id == @tweet.user.id
      erb :'tweets/edit_tweet'
    else
      redirect 'login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
    end
    redirect "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.user == current_user
      @tweet.destroy
    end
    redirect '/tweets'
  end

  #helper methods
  helpers do

    def current_user
      User.find_by(id: session[:id])
    end

    def logged_in?
      !!session[:id]
    end
  end
end