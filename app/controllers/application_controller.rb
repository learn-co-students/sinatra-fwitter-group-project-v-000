
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  def current_user
    @users = User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end


  get '/' do
    erb :index
  end


  get '/signup' do

    if logged_in?
      redirect to'/tweets/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(username: params["username"], password: params["password"], email: params["email"] )
    @user.save
    if @user.username != "" && @user.password != "" && @user.email != ""
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
     if logged_in?
       redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"], password: params["password"])

    if @user
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do

    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end

  end

  get '/user/:id' do
     @user = User.find_by(params[:slug])
     erb :'/users/show'
  end

  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
    erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(params)
      @tweet.user_id = current_user.id
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end



end


#rspec ./spec/controllers/application_controller_spec.rb --fail-fast
