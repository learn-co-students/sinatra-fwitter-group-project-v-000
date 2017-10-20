require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :"index"
  end

  get '/failure' do
    erb :failure
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    end
    erb :"/users/create_user"
  end

  post "/signup" do
    if params.has_value?("")
      redirect "/signup"
    end
    @user = User.create(:username => params[:username], email: params[:email], :password => params[:password])
    session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    end
    erb :"/users/login"
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

  get "/logout" do
    if logged_in?
  		session.clear
  		redirect "/login"
    else
      redirect "/"
    end
	end

  post '/tweets/new' do
    if params.has_value?("")
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      @tweet.save
      redirect "/users/#{current_user.slug}"
    end
  end

  get '/users/:slug' do #user index page
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  get '/tweets' do # all tweets page, only allowed if logged in
    if logged_in?
      @user = User.find(session[:user_id])
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
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

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do #delete action
    @tweet = Tweet.find_by_id(params[:id])

    if @tweet.user_id == current_user.id
      @tweet.delete
      redirect to "/users/#{@tweet.user.slug}"
    else
      redirect '/tweets'
    end
  end

  post "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    if params.has_value?("")
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
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
