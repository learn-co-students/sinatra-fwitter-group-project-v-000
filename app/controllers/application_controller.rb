require './config/environment'

require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "dajkdnjwdnjadnehsfehfe"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :"users/signup"
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    if logged_in?
      redirect '/tweets'
    elsif params.values.include?('')
      redirect '/signup'
    else
      user = User.new(params)
      if user.save
        session[:id] = user.id
        redirect '/tweets'
      end
    end 
  end

  get '/login' do 
    if logged_in?
      redirect to '/tweets'
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params["username"])
    if user && user.authenticate(params["password"])
      session[:id] = user.id
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/users/:slug' do
    erb :'/tweets'
  end

  get "/logout" do 
    session.clear
    redirect to '/login'
  end














  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/index"
    else
      redirect to '/login'
    end
  end

  get "/tweets/new" do 
    if logged_in?
      erb :"tweets/new"
    else
      redirect to "/login"
    end
  end

  post "/tweets" do
    if logged_in?
      if !params["content"].empty?
        @tweet = Tweet.create(content: params["content"], user_id: session[:id])
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/new"
      end
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show"
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
        erb :"tweets/edit"
    else
      redirect to "/login"
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if logged_in? && session[:id]==@tweet.user_id
      if !params["content"].empty?
        @tweet.update(content: params["content"])
      else
        redirect to "/tweets/#{params[:id]}/edit"
      end
    else
      redirect to "/login"
    end
  end

  delete "/tweets/:id/delete" do
    if logged_in?
      @tweet= Tweet.find(params[:id])
      if session[:id]==@tweet.user_id
        @tweet.destroy
        redirect to "/tweets"
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end

end