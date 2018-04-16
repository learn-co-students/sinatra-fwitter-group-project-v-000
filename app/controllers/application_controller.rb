require './config/environment'
require "./app/models/user"

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    end
    @user = self.current_user
    #binding.pry
    erb :'/tweets/index'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    #binding.pry
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
    redirect to "/tweets/new"
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      #binding.pry
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
    redirect to "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
    end
    redirect to "/tweets"
  end

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :signup
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :login
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

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  helpers do
    def current_user
      User.find(session[:id])
    end

    def logged_in?
      !!session[:id]
    end
  end

end
