require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end


  get '/' do
    erb :'index'
  end


  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/failure'
    else
      @user =User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/failure"
    end
  end

    get '/tweets' do
      erb :'tweets/tweets'
    end

    get "/logout" do
    session.clear
    redirect "/"
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    if !logged_in?
      redirect to "/failure"
    else
      tweet = current_user.tweets.build(params)
      tweet.save
    end
    redirect to '/tweets'
  end

  get '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit'
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
     tweet.update(content: params[:content])
     redirect to '/tweets'
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
     tweet.destroy
     redirect to '/tweets'
  end







   helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end