require 'pry'
require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do # '/user/new'
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/user/create_user'
    end
  end

  post '/signup' do
    if (params[:username] == "" || params[:email] == "" || params[:password] == "")
      redirect '/signup'
    else
      user = User.new(username: params[:username])
      user.email = params[:email]
      user.password = params[:password]
      user.save
      session[:id] = user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    if !is_logged_in?
      redirect '/login'
    else
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    end
  end

  get '/login' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/user/login' #displays the login form
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    user = User.find_by_slug(params[:slug])
    @tweets = user.tweets
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      current_user.tweets << Tweet.create(content: params[:content])
      redirect "/tweets"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      @tweet = Tweet.find(params[:id])
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
      redirect "/users/#{current_user.slug}"
      # redirect '/tweets'
    else
      @tweet = Tweet.find(params[:id])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  helpers do
    def is_logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end

end
