require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "youwillnevergetthis"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/create_user'
    end
  end


  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email] , password: params[:password])

    if @user.save && @user.username != "" && @user.email != ""
      session[:user_id] = @user.id
      redirect "/tweets"
    else
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
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect :'/login'
    end
  end

  get "/success" do
    if logged_in?
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do

    session.clear
    redirect "/login"
  end

  get "/tweets/new" do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    if params[:content] != ""
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect :'/tweets'
    else
      redirect :'tweets/new'
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id/edit' do
    @user = User.find(session[:user_id])
    @tweet = Tweet.find(params[:id])
    if params[:content] != "" && @user.id == @tweet.user.id
      @tweet.update(content: params[:content])
      redirect "/tweets"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @user = User.find(session[:user_id])
    @tweet = Tweet.find(params[:id])
    if @user.id == @tweet.user.id
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end

  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/'
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
