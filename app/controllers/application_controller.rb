require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "arcticmonkeys"
  end

  get '/' do
    erb :index
  end

  post '/signup' do
    @user = User.create(params)
    @session = session
    @session[:id] = @user.id
    if is_logged_in? && !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/signup' do
    @session = session
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    @session = session
    @session[:id] = @user.id
    redirect '/tweets'
  end

  get '/logout' do
    session.delete(:id)
    redirect '/login'
  end

  get '/tweets' do
    if is_logged_in?
      @user = User.find_by_id(session[:id])
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/tweets/show_tweets'
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @user = User.find_by_id(session[:id])
      new_tweet = Tweet.create(content: params[:content], user_id: session[:id])
      redirect '/tweets'
    end
  end

  patch '/tweets/:id' do
    @new_tweet = Tweet.find_by_id(params[:id])
    @new_tweet.content = params[:content]
    @new_tweet.save
    redirect "/tweets/#{@new_tweet.id}/edit"
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == session[:id]
      @tweet.destroy
    end
    redirect '/tweets'
  end



  helpers do
    def is_logged_in?
      @session = session
      @session.has_key?(:id) ? true : false
    end

    def current_user
      @session = session
      User.find_by_id(@session[:id])
    end
  end

end
