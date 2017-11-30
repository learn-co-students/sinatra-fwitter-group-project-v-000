require './config/environment'
require "./app/models/user"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

    get "/" do
      erb :index
    end

    get "/signup" do
      # binding.pry
      if !User.exists?(session[:user_id])
        erb :'/users/signup'
      else
        redirect "/tweets"
     end
    end

    post "/signup" do
      if params[:username] == "" || params[:password] == "" || params[:email] == ""
        redirect "/signup"
      else
        user = User.new(:username => params[:username], :password => params[:password])
        user.save
        redirect "/tweets"
     end
    end


    get '/show' do
      @user = User.find(session[:user_id])
      erb :'/users/show'
    end


    get "/login" do
      if !User.exists?(session[:user_id])
        erb :'/users/login'
      else
        redirect "/tweets"
     end
    end

    post "/login" do
      user = User.find_by(:username => params[:username])

      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/show"
      else
          redirect "/signup"
      end
    end


    get "/logout" do
      if !User.exists?(session[:user_id])
        redirect "/login"
      else
        session.clear
        redirect "/login"
      end
    end

    get '/tweets' do
      erb :'/tweets/create_tweet'
    end

    post '/tweets' do
     Tweet.create(content: params[:content])
     redirect '/tweets'
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
