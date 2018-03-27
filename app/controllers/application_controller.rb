require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "hotdog"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
     if !session[:user_id]
       erb :'users/signup'
     else
       redirect '/rooms'
     end
   end

  get '/login' do

    erb :'users/login'
  end

  get '/logout' do
    session.clear
    redirect to "/login"
  end

  get '/users/:slug' do

  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
        erb :'/tweets/tweets'
    else
       redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      #@user = User.find(session[:user_id])
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  post '/signup' do
    @user= User.create(username: params[:username], email: params[:email], password:params[:password])
    session[:user_id]= @user.id
  end

  post '/login' do

  end

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect to '/tweets/new'
      else
        @tweet = Tweet.new(content: params[:content])
        current_user.tweets << @tweet
        current_user.save
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    redirect to "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.id == @tweet.user_id
      @tweet.delete
    elsif logged_in?
      redirect to "tweets/#{@tweet.id}"
    else
      redirect to '/login'
    end
  end

  helpers do

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

  end

end
