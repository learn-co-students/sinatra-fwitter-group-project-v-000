require './config/environment'
require "./app/models/user"
require "./app/models/tweet"

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
    if is_logged_in?
      redirect('/tweets')
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])

    if @user.username == ""
      redirect('/signup')
    elsif @user.email == ""
      redirect('/signup')
    elsif @user.save == false
      redirect('/signup')
    else
      @user.save
      is_logged_in? == true
      session[:user_id] = @user.id
      redirect('/tweets')
    end
  end

  get '/login' do
    if is_logged_in?
      redirect('/tweets')
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect('/tweets')
    end
  end

  get '/tweets' do
    if is_logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      #binding.pry
      erb :'/tweets/show_tweets'
    else
      redirect('/login')
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect('/login')
    else
      redirect('/')
    end
  end

  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])

     erb :'/users/show'
  end

  get '/tweets/new' do
    if !is_logged_in?
      redirect('/login')
    else
      erb :'/tweets/create_tweet'
    end
  end

  get '/tweets/:id' do

    if !is_logged_in?
      redirect('/login')
    else
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/single_tweet'
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(:content => params[:content])

    if @tweet.content != ""
      @tweet = Tweet.create(:content => params[:content])
      @tweet.save
      #binding.pry
      current_user.tweets << @tweet
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect('/tweets/new')
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])

    if !is_logged_in?
      redirect('/login')
    elsif current_user.tweets.include?(@tweet)
      erb :'/tweets/single_tweet'
    else
      redirect('/tweets')
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])

    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if is_logged_in?
      @tweet = Tweet.find_by(id: params[:id])

      if current_user.tweets.include?(@tweet)
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
   end
end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def is_logged_in?
      !!session[:user_id]
    end
  end
end
