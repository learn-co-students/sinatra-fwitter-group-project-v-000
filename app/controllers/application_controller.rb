require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do 
    if logged_in?
      redirect to "/tweets"
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:id] = @user.id
      redirect to "/tweets"
    end
  end

  get '/tweets' do 
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/login' do 
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) 
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/logout' do
    session.clear
    redirect to "/login"
  end

  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/new' do 
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do 
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content])
      @tweet.user = current_user
      @tweet.save
      redirect to "/tweets"
      
    else
      redirect to '/tweets/new'
    end
  end


  get '/tweets/:id/edit' do 
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user    
        erb :'/tweets/edit_tweet'
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id' do 
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/single_tweet'
    else
      redirect to "/login"
    end

  end


  post '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""    
      @tweet.update(content: params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do 
    tweet = Tweet.find(params[:id])
    if logged_in? && current_user.tweets.include?(tweet)
      tweet.delete
      erb :'/tweets/deleted_tweet'
    else
      redirect to "/login"
    end
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end

end