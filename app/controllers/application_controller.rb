require './config/environment'

class ApplicationController < Sinatra::Base

  enable :sessions
  set :session_secret, "my_application_secret"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'/index'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_users'
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'/users/show'
  end

  get '/tweets' do
    if logged_in? && current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in? && current_user
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = current_user.tweets.create(content: params[:content])
    if @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in? && current_user
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in? && current_user
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user == current_user
      if !params[:content].empty?
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  helpers do
    def current_user
      User.find(session[:user_id]) if logged_in?
    end

    def logged_in?
      !!session[:user_id]
    end
  end

end
