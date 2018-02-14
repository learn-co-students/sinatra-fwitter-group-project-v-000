require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret' # Review sessions
  end

  get '/' do
    erb :'/homepage'
  end

  get '/signup' do
    if !logged_in?
      erb :signup
    else
      redirect to '/tweets'
    end
  end

  # try inserting flash[:message] here and on signup page
  # refer to sinatra playlister

  post "/signup" do
    user = User.create(params)
    session[:user_id] = user.id
    if user.save
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets' do
    @user = User.find(session[:user_id]) if session[:user_id]
    if logged_in?
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    if logged_in?
      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect to "/tweets/#{tweet.id}/edit"
      # Have to interpolate here because it's not a get request from the client browser
    else
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    user = User.find(session[:user_id]) if session[:user_id]
    tweet = Tweet.find(params[:id])
    if !!user && tweet.user_id == user.id
      tweet.destroy
    end
  end

  get '/tweets/:id' do
    @user = User.find(session[:user_id]) if session[:user_id]
    @tweet = Tweet.find(params[:id])
    if !!@user
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.create(params)
    tweet.user_id = session[:user_id]
    tweet.save
    if tweet.content == "" # How do I write this solution without hard coding?
      redirect to '/tweets/new'
    else
      redirect to '/tweets'
    end
  end

  get '/login' do
    # @user = User.find(session[:user_id]) if session[:user_id]
    # if current_user.logged_in? # Why doesn't this statement work?
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/login'
    end
  end

  get '/logout' do
    logout
    redirect to '/login'
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end

  get '/index' do
    if logged_in?
      redirect to '/tweets'
    elsif !logged_in?
      raise "must log in to view index"
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    # Analyze below method and previous errors
    # Before without `if session[:id]` error in browser was
    # no 'id'= since User.find() was executing no matter what
    # without a conditional statement.
    # We need the conditional statement there in order to prevent
    # the error.
    # Why use the double pipes?

    def current_user
      # User.find(session[:user_id]) did not work
      # but User.find_by(id: session[:user_id]) works... Why?
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logout
      session.clear
    end
  end
end
