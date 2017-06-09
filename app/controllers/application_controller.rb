require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "abcdefghijklmnop"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by(id: session[:user_id])
    end
  end


  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    redirect "/users/signup" if params[:username] == "" || params[:email] == "" || params[:password] == ""

    user = User.new
    user.username = params[:username]
    user.email = params[:email]
    user.password = params[:password]
    user.save
    session[:user_id] = user.id

    redirect "/tweets"
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/login"
    end
  end 

  post '/login' do
    redirect "/users/login" if params[:username] == "" || params[:password] == ""
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear if logged_in?
    redirect "/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

  # Tweet related

  get '/tweets' do
    if !logged_in?
      redirect "/login"
    else
      @tweets = Tweet.all
      erb :"tweets/tweets"
    end
  end

  get '/tweets/new' do
    redirect "/login" if !logged_in?

    erb :"tweets/new"
  end

  get '/tweets/:id' do
    redirect "/login" if !logged_in?

    @tweet = Tweet.find_by(id: params[:id])

    erb :"tweets/show"
  end

  get '/tweets/:id/edit' do
    redirect "/login" if !logged_in?

    @tweet = Tweet.find_by(id: params[:id])
  
    erb :"tweets/edit"
  end

  post '/tweets' do
    redirect "/tweets/new" if params[:content] == ""

    @tweet = Tweet.create(params)
    @tweet.user = current_user
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
  end

  patch '/tweets/:id' do
    redirect "/tweets/#{params[:id]}/edit" if params[:content] == ""

    @tweet = Tweet.find_by(id: params[:id])
    @tweet.update(content: params[:content])

    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    redirect "/login" if !logged_in?

    @tweet = Tweet.find_by(id: params[:id])
    @tweet.delete if @tweet.user.id == current_user.id

    redirect "/tweets"
  end

end