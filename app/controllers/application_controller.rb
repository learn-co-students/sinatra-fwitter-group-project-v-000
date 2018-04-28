require './config/environment'

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
    if logged_in?
      redirect '/tweets'
    end
      erb :'/users/create_user'
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to "/tweets"
      else
        redirect to "/login"
      end
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect to "/login"
      else
        redirect to "/"
      end
    end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    end

    get '/tweets/new' do
      if logged_in?
        erb :'/tweets/create_tweet'
      else
        redirect to '/login'
      end
    end

    get '/tweets' do
      if logged_in?
        @user = current_user
        erb :'/tweets/tweets'
      else
        redirect to "/login"
      end
    end

    post '/tweets' do
      @user = current_user
        if params[:content] != ""
          @tweet = Tweet.create(content: params[:content], user_id: @user.id)
          @tweet.save
          erb :'/tweets/tweets'
        else
          redirect :'/tweets/new'
        end
      end

    get '/tweets/:id/edit' do
      if logged_in?
        @user = current_user
        @tweet=Tweet.find(params[:id])
        erb :"/tweets/edit_tweet"
      else
        redirect to "/login"
      end
    end

    get '/tweets/:id' do
      if logged_in?
        #binding.pry
        @tweet=Tweet.find(params[:id])
        erb :'/tweets/show_tweet'
      else
        redirect to "/login"
      end
    end

    patch '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      @user=current_user
      if logged_in?
        if params[:content].strip != ""
        @tweet = Tweet.update(params[:id], content: params[:content])
        @tweet.save
        erb :'/tweets/tweets'
        else
          redirect to '/tweets/1/edit'
        end
      else
        redirect to '/login'
      end
    end

    post '/tweets/:id/delete' do
      if logged_in?
        @tweet=Tweet.find(params[:id])
        if @tweet.user_id == current_user.id
          @tweet.destroy
        end
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
