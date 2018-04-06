require './config/environment'
require "./app/models/user"
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

    get '/' do
      erb :'index'
    end

    	get '/signup' do
        if logged_in? == false
    		erb :'/users/create_user'
      else
        redirect '/tweets'
      end
    	end

    	post '/signup' do
    			user = User.new(username: params[:username], password: params[:password], email: params[:email])
            if user.valid? && logged_in? == false
    					user.save
              session[:user_id] = user.id
    					redirect "/tweets"
    			else
    					redirect '/signup'
    			end
    		end

    	get '/login' do
    		erb :'users/login'
    	end

    	post "/users/login" do #where do we want this to go??
    		 @user = User.find_by(username: params[:username])
    		 	if @user && @user.authenticate(params[:password])
    				session[:user_id] = @user.id
    				redirect "/tweets"
    			else
    				redirect "/signup"
    			end
    	end

      get "/tweets" do
    		if logged_in?
          @user = User.find_by(id: session[:user_id])
          @tweets = Tweet.all
    			erb :'tweets/tweets'
    		else
    			redirect "/users/login"
    		end
    	end

      post "/tweets" do
        tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
        redirect "/tweets"
      end

      get "/tweets/new" do
        if logged_in?
          @user = User.find_by(id: session[:user_id])
          erb :'tweets/create_tweet'
        else
          redirect "/users/login"
        end
      end

    	get "/logout" do
        if logged_in?
          session.clear
          redirect "/"
        else
          redirect "/users/login"
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
