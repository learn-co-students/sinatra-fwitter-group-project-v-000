class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:id]
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if empty_fields?
      redirect '/signup'
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find_by(id: session[:id])
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    # binding.pry
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content])
      @user = current_user
      @user.tweets << @tweet
      @user.save
    else
      redirect '/tweets/new'
    end
    # binding.pry
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/users/login'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end

    # def create_user
    #   User.create(username: params[:username], password: params[:username])
    # end
  end
  private
  def empty_fields?
    params[:username].empty? || params[:password].empty? || params[:email].empty?
  end
end
