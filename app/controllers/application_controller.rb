require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_secure"
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do
    if session[:user_id] == nil
      erb :'users/signup'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username],email: params[:email], password: params[:password])

    if @user.save
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
      end
      redirect to '/tweets'
    else
      redirect to '/users/signup'
    end

  end

  get '/login' do
    if session[:user_id] == nil
      erb :'users/login'
    else
      @user = User.find_by(username: params[:username])
      redirect to '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/users/signup'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'tweets/tweets'  
    else
      redirect to '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :'tweets/show_tweet'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/users/login'
    end
  end

  post '/tweets' do
  
    if logged_in? && (params[:content] != "")
      user = User.find_by(session[:user_id])
      tweet = Tweet.new(content: params[:content])
      tweet.user_id = user.id
      tweet.save

      redirect to "/tweets/#{tweet.id}"
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && (params[:content] != "")
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])

    if session[:user_id] == @tweet.user_id
      @tweet.delete
    end

  end

  get "/logout" do
    if session[:user_id] != nil
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end

  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

  #   def current_user
  #     User.find(session[:user_id])
  #   end
  end

end
