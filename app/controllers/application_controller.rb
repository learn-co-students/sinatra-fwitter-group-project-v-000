require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :home
  end

  get '/login' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect'/tweets'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :"users/signup"
    end
  end

  post '/signup' do
    if params[:password] == ""
      redirect '/signup'
    end
    user = User.new(params)
    if user.username != "" && user.email != ""
      user.save
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end

  get "/failure" do
    erb :"users/failure"
  end

  get '/tweets' do
    @tweets = Tweet.all
    if is_logged_in?
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"tweets/tweets"
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :"tweets/new"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if is_logged_in?
      erb :"tweets/show"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit"
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content] != ""
      tweet.content = params[:content]
      tweet.save
      redirect '/tweets'
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if current_user.tweets.include?(tweet)
      tweet.delete
    end
    redirect '/tweets'
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
