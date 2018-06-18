require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end
    set :public_folder, 'public'
    set :views, 'app/views'

    get '/' do
      erb :index
    end

    def logged_in?
      !!session[:user_id]
    end

    get '/signup' do
      if self.logged_in?
          redirect "/tweets"
      else
        erb :'/users/create_user'
      end
    end

    post '/signup' do
      if params[:username]=="" || params[:email]==""|| params[:password]==""
        redirect "/signup"
      else
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect "/tweets"
      end
    end

    get '/login' do
        if self.logged_in?
          redirect "/tweets"
        else
          erb :'/users/login'
        end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        redirect "/login"
      end

    end

    get '/logout' do
      if self.logged_in?
        session.clear
        redirect "/login"
      else
        redirect "/"
      end
    end

    get '/tweets' do

    if logged_in?
      @tweets = Tweet.all
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    end

    get '/tweets/new' do
      if self.logged_in?
        erb :'/tweets/create_tweet'
      else
        redirect "/login"
      end
      end

    post '/tweets/new' do
      @user = User.find(session[:user_id])
      if self.logged_in? && params[:content] != ""
        @user.tweets << Tweet.new(content: params[:content])
        redirect "/users/#{@user.slug}"
      else
        redirect "/tweets/new"
      end
    end

    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.all.find(params[:id])
        erb :'tweets/edit_tweet'
      else
        redirect "/login"
      end
    end

    patch '/tweets/:id' do
      @tweet = Tweet.all.find(params[:id])
      if session[:user_id] == @tweet.user_id && params[:content] != ""
        @tweet.update(content: params[:content])
        @tweet.save
        "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    end

    get '/tweets/:id' do
      @tweet = Tweet.all.find(params[:id])
      if logged_in?

        erb :'tweets/show_tweet'
      else
        redirect "/login"
      end
    end


  post '/tweets/:id/delete' do
    @tweet = Tweet.all.find(params[:id])
    if session[:user_id] == @tweet.user_id
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end




end
