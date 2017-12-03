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


    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
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
          redirect "/tweets"
      else
          redirect "/signup"
      end
    end


    get "/logout" do
      if !User.exists?(session[:user_id])
        redirect "/"
      else
        session.clear
        redirect "/login"
      end
    end

    get '/tweets/new' do
      if logged_in?
       erb :'/tweets/create_tweet'
      else
       redirect "/login"
     end
    end

    post '/tweets' do
     @user = current_user
     if params[:content] == ""
       redirect "/tweets/new"
     else
       @tweet = Tweet.create(content: params[:content])
       @tweet.user_id = @user.id
       @tweet.save
       redirect '/tweets'
     end
    end

    get '/tweets' do
      if logged_in?
       @tweets = Tweet.all
        erb :'/tweets/tweets'
     else
      redirect "/login"
     end
    end

    get '/tweets/:slug'do
     if logged_in?
       @tweet = Tweet.find(params[:slug])
       erb :'tweets/show_tweet'
     else
       redirect "/login"
     end
    end

    get '/tweets/:slug/edit' do
     if logged_in?
      @tweet = Tweet.find(params[:slug])
      erb :'tweets/edit_tweet'
     else
     redirect "/login"
    end

    end

    patch '/tweets/:slug' do
     @tweet = Tweet.find(params[:slug])
     if params[:content] == ""
       redirect "/tweets/#{params[:slug]}/edit"
     else
     @tweet.update(content: params[:content])
     redirect "/tweets/#{params[:slug]}"
     end
    end

    delete '/tweets/:slug/delete' do
      @tweet = Tweet.find(params[:slug])
     if logged_in? && @tweet.user_id == current_user.id
      @tweet.delete
     else
      redirect "/login"
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
