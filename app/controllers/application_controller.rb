require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
  include Concerns::HelperMethods

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if is_logged_in?(session)
      redirect to "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save && user.username.length > 0
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if is_logged_in?(session)
      redirect to "/tweets"
    else
      erb :'/users/login'
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    if is_logged_in?(session)
      session.clear
      redirect to "/login"
    else
      redirect to "/tweets"
    end
  end

  get '/tweets' do
    @user = current_user(session)
    if is_logged_in?(session)
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/tweets/new' do
    if is_logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] != ""
      @user = current_user(session)
      @user.tweets << Tweet.create(params)
      redirect to '/tweets'
    end
    redirect to :'/tweets/new'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if @tweet && is_logged_in?(session)
      erb :'/tweets/show_tweet'
    elsif !is_logged_in?(session)
      redirect to '/login'
    else
      redirect to '/tweets'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      @user = current_user(session)
      if @user.id == @tweet.user_id
        erb :'/tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end

    #@tweet = Tweet.find(params[:id])
    #if @tweet && is_logged_in?(session)
    #  erb :'/tweets/edit_tweet'
    #elsif !is_logged_in?(session)
    #  redirect to '/login'
    #else
    #  redirect to '/tweets'
    #end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.update(:content => params[:content])
    end
  end

  post '/tweets/:id/delete' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      @user = current_user(session)
      if @user.id == @tweet.user_id
        @tweet.delete
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

end
