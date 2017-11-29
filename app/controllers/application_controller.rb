require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :homepage
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :login
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

  	 if user && user.authenticate(params[:password])
  			 session[:user_id] = user.id
         #binding.pry
  			 redirect '/tweets'
  	 else
  			 redirect "/failure"
  	 end
  end

  get '/tweets/new' do
    if logged_in?
      erb :new
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      Tweet.create(:content => params[:content], :user_id => current_user.id)
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id/edit' do #loads form to edit
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        erb :edit
      end
    else
      redirect to '/login'
    end
  end

  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :signup
    end
  end

  post "/signup" do
    if(params[:username] != "" && params[:email] != "" && params[:password] != "")
      user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    else
      redirect "/signup"
    end
		if user.save
       session[:user_id] = user.id
       redirect "/tweets"
		else
			 redirect "/failure"
		end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :user
  end

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all

      erb :tweets
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      erb :show
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if params[:content] != "" && @tweet.user_id == session[:user_id]
      @tweet.content = params[:content]
      @tweet.save
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if(@tweet.user_id == session[:user_id])
        Tweet.delete(params[:id])
        redirect "/delete"
      else
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end

  get '/delete' do
    if logged_in?
      erb :delete
    else
      redirect '/login'
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/login"
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
