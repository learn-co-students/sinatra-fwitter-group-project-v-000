require './config/environment'

class ApplicationController < Sinatra::Base

  before do
    @user = User.find_by(id: session[:user_id])
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "chirp"
  end

  get '/' do
    erb :'/index'
  end

  get '/signup' do
    return redirect '/tweets' if session[:user_id]
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    return redirect '/tweets' if session["user_id"]
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    return redirect '/login' unless session[:user_id]
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    return redirect '/login' unless session[:user_id]
    erb :'/tweets/create_tweet'
  end

  post '/tweets/new' do
    return redirect '/login' unless session[:user_id]
    @tweet = Tweet.new(tweet_params)
    @tweet.save if @tweet.valid?
    redirect '/tweets/new'
  end

  get '/tweets/:tweet_id' do
    return redirect '/login' unless session[:user_id]
    @tweet = Tweet.find_by(id: params[:tweet_id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:tweet_id/edit' do
    return redirect '/login' unless session[:user_id]
    @tweet = Tweet.find_by(id: params[:tweet_id])
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/:tweet_id/edit' do
    return redirect '/login' unless session[:user_id]
    @tweet = Tweet.find_by(id: params[:tweet_id])
    if @tweet.user_id == session[:user_id] && params[:content] != ""
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:tweet_id/delete' do
    return redirect '/login' unless session[:user_id]
    @tweet = Tweet.find_by(id: params[:tweet_id])
    @tweet.delete if session[:user_id] == @tweet.user_id
    redirect '/tweets'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'/users/show'
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  private

  def user_params
    {username: params[:username], password: params[:password], email: params[:email]}
  end

  def tweet_params
    {user_id: session[:user_id], content: params[:content]}
  end

end
