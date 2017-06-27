require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
   use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_password"
  end



    get '/' do
      erb :index
    end


    get '/tweets' do
      if logged_in?
        @user = current_user
        @tweets = Tweet.all
        erb :'/tweets/tweets'
      else
        redirect "/login"
      end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @tweets = @user.tweets
     erb :'/tweets/tweets'
    end


    get '/tweets/new' do
      if logged_in?
        erb :'/tweets/create_tweet'
      else
        redirect "/login"
      end
    end

    post '/tweets' do
      user = current_user
      tweet = user.tweets.build(content: params[:content])
      if tweet.valid?
        user.save
        redirect "/tweets"
      else
        flash[:content] = "Your tweet is blank!"
        redirect '/tweets/new'
      end
    end


    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id == session[:id]
          erb :'/tweets/edit_tweet'
        else
         redirect "/tweets/#{@tweet.id}"
        end
      else
        redirect "/login"
      end
    end

    post '/tweets/:id' do
      tweet = Tweet.find(params[:id])
      tweet.content = params[:content]
      if tweet.save
        redirect "/tweets"
      else
        flash[:content] = "Your tweet is blank!"
        redirect "/tweets/#{tweet.id}/edit"
      end
    end


    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show_tweet'
      else
        redirect "/login"
      end
    end


    delete '/tweets/:id/delete' do
      @user = current_user
      @tweet = Tweet.find(params[:id])
      if logged_in? && @tweet.user_id == session[:id]
        @tweet.destroy
        redirect "/tweets"
      else
        redirect "/tweets/#{@tweet.id}"
      end
    end


    get '/signup' do
      if logged_in?
        redirect "/tweets"
      else
        erb :'/users/create_user'
      end
    end

    post '/signup' do
      user = User.new(params)
      if user.save
        session[:id] = user.id
        redirect "/tweets"
      else
        flash[:fields] = "You have missing required fields."
        redirect "/signup"
      end
    end


    get '/login' do
      if logged_in?
        redirect "/tweets"
      else
        erb :'/users/login'
      end
    end

    post '/login' do
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:id] = user.id
        redirect "/tweets"
      else
        flash[:wrong] = "Oops, try again, please."
        redirect "/login"
      end
    end


    get '/logout' do
      session.clear
      redirect '/login'
    end

    helpers do
      def current_user
      @current_user ||= User.find(session[:id])
    end

    def logged_in?
      !!session[:id]
    end
  end
end
