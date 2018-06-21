require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "burritos"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:id] 
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @new_user = User.new(username: params['username'], email: params['email'], password: params['password'])

    if @new_user.save && !@new_user.username.empty? && !@new_user.email.empty?
      session[:id] = @new_user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end

  end

  get '/login' do
    if session[:id]
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @logged_user = User.find_by(username: params['username'])
    if @logged_user && @logged_user.authenticate(params['password']) 
      session[:id] = @logged_user.id
      redirect to '/tweets'
    else
      redirect to '/'
    end
  end

  get '/logout' do
      session.clear
      redirect to '/login'
  end

  get '/tweets' do
    if session[:id]
      @user = User.find(session[:id])
      @user_tweets = @user.tweets
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if session[:id] 
      @user = User.find(session[:id])
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if session[:id] && !params[:content].empty?
      @user = User.find(session[:id])
      @user.tweets.build(content: params[:content])
      @user.save
      redirect to '/tweets'
    elsif session[:id]
      redirect to '/tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @user_tweets = @user.tweets
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/:id' do
    if session[:id]
      @user = User.find(session[:id])
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:id]
      @tweet = Tweet.find(params[:id])
      @user = User.find(session[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end

  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if session[:id] && !params[:content].empty? && session[:id] == @tweet.user_id
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    elsif session[:id]
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      redirect to '/login'
    end
  end
  

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if session[:id] && session[:id] == @tweet.user_id
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end


end
