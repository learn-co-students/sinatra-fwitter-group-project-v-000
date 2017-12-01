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
        @user = User.new(:username => params[:username], :password => params[:password])
        @user.save
        session[:user_id] = @user.id
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
      @user = User.find_by(:username => params[:username])

      if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
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
        redirect "/"
      end
    end

    get '/tweets/new' do
      erb :'/tweets/create_tweet'
    end

    post '/tweets' do
     Tweet.create(content: params[:content])
     redirect '/tweets'
    end

    get '/tweets' do
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    end

    get '/tweets/:id'do
     @tweet = Tweet.find(params[:id])
     erb :'tweets/show_tweet'
    end

    get '/tweets/:id/edit' do
     @tweet = Tweet.find(params[:id])
     erb :'tweets/edit_tweet'
    end

    patch '/tweets/:id' do
     @tweet = Tweet.find(params[:id])
     @tweet.update(content: params[:content])
     redirect "/tweets/#{params[:id]}"
    end

    delete '/tweets/:id/delete' do
      @tweet = Tweet.find(params[:id])
      @tweet.delete
      erb :delete
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
